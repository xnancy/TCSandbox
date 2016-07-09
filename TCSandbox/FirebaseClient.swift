//
//  FirebaseClient.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/7/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class FirebaseClient: AnyObject {
    static let ref = FIRDatabase.database().reference()

    // Saves current user to Firebase
    class func saveUser()
    {
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
            //checkUserIDExists(FBID)
            //save friends too and challenges
            
            
            /*//facebook authentication
             let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
             FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
             if let error = error {
             print(error.localizedDescription)
             return
             }
             }*/
            
            //save information to firebase if user not currently in DB
            let user: NSDictionary = ["FBID":FBID,"email":email, "profileImageURLString":profileImageURLString]
            let profile = ref.child("Users").child(FBID)
            profile.setValue(user)
            
        })
    }
    
   
}
