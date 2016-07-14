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

    static let dataRef = FIRDatabase.database().reference()

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
            
            let user: NSDictionary = ["FBID":FBID,"email":email, "profile_picture_url":profileImageURLString,"name":name]
            let profile = dataRef.child("Users").child(FBID)
            profile.updateChildValues(user as [NSObject : AnyObject])
            
            dataRef.child("Users").child(FBID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
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
                    let friendsList: [String] = [FBID]
                    let currentChallenges: [String] = ["placeholder"]
                    let pastChallenges: [String] = ["placeholder"]
                    let challengesCompleted: Int = 0
                    let updates = ["friends_list": friendsList, "current_challenges": currentChallenges, "past_challenges": pastChallenges, "challenges_completed": challengesCompleted]
                    dataRef.child("Users").child(FBID).updateChildValues(updates as [NSObject : AnyObject])
                    
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
        
        dataRef.child("Users").child(FBID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var friendsList = snapshot.value!["friends_list"] as! [String]
            
            if friendsList.contains(friend)
            {
                return
            }
            
            friendsList.append(friend)
            let updates = ["friends_list": friendsList]
            dataRef.child("Users").child(FBID!).updateChildValues(updates)
            User.currentUser?.friends = friendsList
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    class func removeFriend(friend: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        dataRef.child("Users").child(FBID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var friendsList = snapshot.value!["friends_list"] as! [String]
            
            if let index = friendsList.indexOf(friend)
            {
                friendsList.removeAtIndex(index)
                let updates = ["friends_list": friendsList]
                dataRef.child("Users").child(FBID!).updateChildValues(updates)
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
        //UPLOAD GIFS AND MOVES TO FIREBASE TOO, ALSO INCLUDE VIDEO POSSIBLY
        
        let challengeID = dataRef.child("Challenges").childByAutoId().key
        challenge.challengeID = challengeID
        
        let participants = challenge.participants
        let gifNames = challenge.gifNames
        let tagNames = challenge.tagNames
        let timeLimit = challenge.timeLimit

        
        for userID in participants!
        {
            //add challenge to user in firebase and user's current challenges
            dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                
                var currentChallenges = snapshot.value!["current_challenges"] as! [String]
                currentChallenges.append(challengeID)
                
                let updates = ["current_challenges": currentChallenges]
                dataRef.child("Users").child(userID).updateChildValues(updates)
                //REFRESH THE USER'S CURRENT CHALLENGES
                
            })  { (error) in
                
                print(error.localizedDescription)
            }
            
            dataRef.child("Challenges").updateChildValues(["challengeID": challengeID])
            dataRef.child("Challenges").child(challengeID).updateChildValues(["participants": participants!, "workout_gifs": gifNames!, "add_on_images": tagNames!, "time_limit": timeLimit!])
            
        }
    }
    
    class func declineChallenge(challenge: Challenge)
    {
        //THIS REMOVES THE USER FROM THE PARTICIPANTS AND THE CHALLENGE FROM THE USER'S CURRENT CHALLENGES
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        let challengeID = challenge.challengeID
        
        dataRef.child("Users").child(FBID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var participants = snapshot.value!["participants"] as! [String]
            var currentChallenges = snapshot.value!["current_challenges"] as! [String]
            let indexOfChallenge = currentChallenges.indexOf(challengeID!)
            let indexOfUser = participants.indexOf(FBID)
            currentChallenges.removeAtIndex(indexOfChallenge!)
            participants.removeAtIndex(indexOfUser!)
            
            
            dataRef.child("Users").child(FBID).updateChildValues(["current_challenges": currentChallenges])
            dataRef.child("Challenges").child(challengeID!).updateChildValues(["participants": participants])
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    /* ---------- FRIENDS ---------- */
    // Creates a closure callback that continually updates a user's friends ID list in a user object
    class func updateFriends(user: User) {
        // Attach a closure to read the data at our posts reference
        dataRef.child("Users").child(user.FBID!).child("friends_list").observeEventType(.ChildAdded, withBlock: { snapshot in
            user.friends?.append(snapshot.value as! String)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    // Returns user object retrieved from Firebase given userID
    class func getUserFromID (userID: String) -> User {
        var tempUser: User?
        dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            tempUser = User(dict: snapshot as! NSDictionary)
        })
        return tempUser!
    }
    
    class func uploadVideo(videoURL: NSURL, challengeKey: String)
    {
        //upload video to vimeo
        //update challenge video urls with this stream url
        
    }
}
