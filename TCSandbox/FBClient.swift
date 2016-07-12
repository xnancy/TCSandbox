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
                    
                    let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, friends: friendsList)
                    User.currentUser = currentUser
                }
                
                else
                {
                    //initialize a new empty friends array with string
                    //placeholder
                    let friendsList: [String] = ["placeholder"]
                    let updates = ["friends_list": friendsList]
                    ref.child("Users").child(FBID).updateChildValues(updates)
                    
                    let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, friends: friendsList)
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
        let FBID = User.currentUser?.FBID
        
        ref.child("Users").child(FBID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            //upon login everyone gets a friend array, so just check if
            //the array has a placeholder or an actual id and respond
            //accordingly
            
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }

}