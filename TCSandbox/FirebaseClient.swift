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
    }
    
    class func logout()
    {
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
