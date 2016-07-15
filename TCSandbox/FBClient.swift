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

                print(friendsExist)
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
                    let challenges: [String] = ["placeholder"]
                    let challengesCompleted: Int = 0
                    let updates = ["friends_list": friendsList, "current_challenges": challenges, "challenges_completed": challengesCompleted]
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
    
    class func addFriend(friendID: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        dataRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let userDict = snapshot.value![FBID]
            var userFriendsList = userDict!!["friends_list"] as! [String]
            
            var friendDict = snapshot.value![friendID]
            var friendFriendsList = friendDict!!["friends_list"] as! [String]
            
            userFriendsList.append(friendID)
            friendFriendsList.append(FBID)
            
            let userUpdates = ["friends_list": userFriendsList]
            let friendUpdates = ["friends_list": friendFriendsList]
            
            dataRef.child("Users").child(FBID).updateChildValues(userUpdates)
            dataRef.child("Users").child(friendID).updateChildValues(friendUpdates)

            
            User.currentUser?.friends = userFriendsList
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    class func removeFriend(friendID: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        dataRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            let userDictionary = snapshot.value![FBID]
            let friendDictionary = snapshot.value![friendID]
            
            var userFriendsList = userDictionary!!["friends_list"] as! [String]
            var friendFriendsList = friendDictionary!!["friends_list"] as! [String]
            
            if let index = friendFriendsList.indexOf(FBID)
            {
                friendFriendsList.removeAtIndex(index)
                let updates = ["friends_list": friendFriendsList]
                dataRef.child("Users").child(friendID).updateChildValues(updates)
            }
            
            if let index = userFriendsList.indexOf(friendID)
            {
                userFriendsList.removeAtIndex(index)
                let updates = ["friends_list": userFriendsList]
                dataRef.child("Users").child(FBID).updateChildValues(updates)
                User.currentUser?.friends = userFriendsList
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
                
                
                var currentChallenges = snapshot.value!["challenges"] as! [String]
                currentChallenges.append(challengeID)
                
                let updates = ["challenges": currentChallenges]
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
            var currentChallenges = snapshot.value!["challenges"] as! [String]
            let indexOfChallenge = currentChallenges.indexOf(challengeID!)
            let indexOfUser = participants.indexOf(FBID)
            currentChallenges.removeAtIndex(indexOfChallenge!)
            participants.removeAtIndex(indexOfUser!)
            
            
            dataRef.child("Users").child(FBID).updateChildValues(["challenges": currentChallenges])
            dataRef.child("Challenges").child(challengeID!).updateChildValues(["participants": participants])
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    /* ---------- FRIENDS/USERS ---------- */
    // Creates a closure callback that continually updates a user's friends ID list in a user object
    class func updateFriends(user: User, completion: ([String]) -> Void) {
        // Attach a closure to read the data at our posts reference
        dataRef.child("Users").child(user.FBID!).observeSingleEventOfType(.Value, withBlock: { snapshot in
            user.friends = []
            for friend in snapshot.value!["friends_list"] as! [String] {
                user.friends?.append(friend)
            }
            completion(user.friends!)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    /*
    // Sets user object using data retrieved from Firebase given userID
    class func getUserFromID (userID: String, user: User) {
       dataRef.childByAppendingPath("Users").childByAppendingPath(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
        let dict = snapshot.value as! NSDictionary
            print (dict)
            user.FBID = dict["FBID"] as! String
            user.email = dict["email"] as! String
            user.name = dict["name"] as! String
            user.profileImageURLString = dict["profile_picture_url"] as! String
            user.friends = dict["friends_list"] as! [String]
            user.currentChallenges = dict["current_challenges"] as! [String]
            user.pastChallenges = dict["past_challenges"] as! [String]
            user.challengesCompleted = dict["challenges_completed"] as! Int  })
    }*/
    
    // Returns user from userID
    class func getUser (userID: String) -> User{
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
    
    /* ---------- FRIEND CELL GENERATION ---------- */
    class func generateFriendCell(friendID: String, cell: FriendsSendChallengeTableViewCell) {
        
        dataRef.childByAppendingPath("Users").childByAppendingPath(friendID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let url = NSURL(string: dict["profile_picture_url"] as! String)
            cell.userProfileImageView.setImageWithURL(url!)
            cell.userNameLabel.text = dict["name"] as! String
            cell.userChallengeCompletedLabel.text = "\(dict["challenges_completed"] as! NSNumber)"
        })
    }
    
    class func generateFriendSearchCell(friendID: String, cell: searchFriendsTableViewCell) {
        dataRef.childByAppendingPath("Users").childByAppendingPath(friendID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let url = NSURL(string: dict["profile_picture_url"] as! String)
            cell.profileImageView.setImageWithURL(url!)
            cell.nameTextLabel.text = dict["name"] as! String
            cell.challengesCompletedLabel.text = "Completed: \(dict["challenges_completed"] as! NSNumber)"
        })
    }
    
    /* ---------- GENERAL LISTS ---------- */
    // Fills [String: String] with list of all userID: name in database
    class func generateNonFriendUserIDList(dictionary: NSMutableDictionary, delegate: AddFriendViewControllerDelegate) {
        dataRef.childByAppendingPath("Users").observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let currentUserID = FBSDKAccessToken.currentAccessToken().userID
            let friendsList = dict.valueForKey(currentUserID)?.valueForKey("friends_list") as! [String]
            for element in dict.allKeys as! [String] {
                let id = dict[element]!["FBID"] as! String
                if (!friendsList.contains(id)) {
                    dictionary.setValue(dict[element]!["name"] as! String, forKey: dict[element]!["FBID"] as! String)
                }
            }
            delegate.reloadFriendTable()
        })
    }
}
