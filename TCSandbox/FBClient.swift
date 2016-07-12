//
//  FBClient.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class FBClient: AnyObject {

    static let ref = FIRDatabase.database().reference()

    class func login()
    {
        //facebook authentication in Firebase
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        let parameters = ["fields": "email, name, id, picture.type(large)"]
        
        // FB get current user
        let request = FBSDKGraphRequest(graphPath: "me", parameters: parameters, tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
        
        // POST current user to Firebase
        request.startWithCompletionHandler({ (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError)
                return
            }
            
            var pictureUrl = ""
            
            if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                pictureUrl = url
            }
            
            let FBID = user["id"] as! String
            let email = user["email"] as! String
            let profileImageURLString = pictureUrl
            let name = user["name"] as! String
            
            let user: NSDictionary = ["FBID":FBID,"email":email, "profileImageURLString":profileImageURLString]
            let profile = ref.child("Users").child(FBID)
            profile.updateChildValues(user as [NSObject : AnyObject])
            
            ref.child("Users").child(FBID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                let friendsExist = snapshot.hasChild("friends_list")

                //FIX THIS TO HANDLE EMPTY CHALLENGES TOO
                
                if friendsExist
                {
                    //do nothing
                    let friendsList = snapshot.value!["friends_list"] as! [String]
                    
                    let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, name: name, friends: friendsList)
                    User.currentUser = currentUser
                }
                
                else
                {
                    //initialize a new empty friends array with string
                    //placeholder
                    let friendsList: [String] = ["placeholder"]
                    let currentChallenges: [String] = ["placeholder"]
                    let pastChallenges: [String] = ["placeholder"]
                    let challengesCompleted: Int = 0
                    let updates = ["friends_list": friendsList, "current_challenges": currentChallenges, "past_challenges": pastChallenges, "challenges_completed": challengesCompleted]
                    ref.child("Users").child(FBID).updateChildValues(updates as [NSObject : AnyObject])
                    
                    let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, name: name, friends: friendsList)
                    User.currentUser = currentUser
                }
                
            })  { (error) in
                
                print(error.localizedDescription)
            }
        })
    }
    
    class func logout()
    {
        FBSDKAccessToken.setCurrentAccessToken(nil)
        User.currentUser = nil
        try! FIRAuth.auth()!.signOut()
    }
    
    class func addFriend(friend: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        ref.child("Users").child(FBID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var friendsList = snapshot.value!["friends_list"] as! [String]
            
            if friendsList.contains(friend) //CHECK IF FRIEND ALREADY EXISTS
            {
                return
            }
            
            friendsList.append(friend)
            let updates = ["friends_list": friendsList]
            ref.child("Users").child(FBID!).updateChildValues(updates)
            User.currentUser?.friends = friendsList
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    class func removeFriend(friend: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        ref.child("Users").child(FBID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var friendsList = snapshot.value!["friends_list"] as! [String]
            
            if let index = friendsList.indexOf(friend)
            {
                friendsList.removeAtIndex(index)
                let updates = ["friends_list": friendsList]
                ref.child("Users").child(FBID!).updateChildValues(updates)
                User.currentUser?.friends = friendsList
            }
                
                else
            {
                return
            }
            
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    class func uploadChallenge(challenge: Challenge)
    {
        //FINISH WRITING THIS
        
        
        let key = ref.child("Challenges").childByAutoId().key
        let users = challenge.getUsers()
        
        //ADD CHALLENGE TO EACH USER'S CURRENT CHALLENGES
        for user in users
        {
            user.currentChallenges?.append(challenge)
            
            //also add challenge to user in firebase
            let FBID = user.FBID
            
            ref.updateChildValues(["challengeID": key])
            
            //add the challenge to the user under this key
            //initialize the challenge object with this key
            //add a challenges child with this key

        }
    }
    
    /* ---------- FRIENDS ---------- */
    // Creates a closure callback that continually updates a user's friends ID list in a user object
    class func updateFriends(user: User) {
        // Attach a closure to read the data at our posts reference
        ref.childByAppendingPath("Users").childByAppendingPath(user.FBID!).childByAppendingPath("friends_list").observeEventType(.ChildAdded, withBlock: { snapshot in
            user.friends?.append(snapshot.value as! String)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    // Returns user object retrieved from Firebase given userID
    class func getUserFromID (userID: String) -> User {
        var tempUser: User?
        ref.childByAppendingPath("Users").childByAppendingPath(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            tempUser = User(dict: snapshot as! NSDictionary)
        })
        return tempUser!
    }
    
    // Adds friendID to userID friend list
    // Assumes: userID, friendID are valid
    class func addFriendFromID (userID: String, friendID: String) {
        
    }

}
