//
//  User.swift
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

class User: AnyObject {
    var FBID: String?
    var profileImageURLString: String?
    var email: String?
    var friends: [String]?
    var currentChallenges: [Challenge]?
    var pastChallenges: [Challenge]?
    
    static var currentUser: User?
    
 
    init(FBID: String?, email: String?, profileImageURLString: String?, friends: [String])
    {
        self.FBID = FBID
        self.email = email
        self.profileImageURLString = profileImageURLString
        self.friends = friends
        self.currentChallenges = []
    }
    
    class func logout()
    {
        User.currentUser = nil
        FirebaseClient.logout()
        FBClient.logout()
    }
    
    func upload(challenge: Challenge)
    {
        
    }
    
    func remove(challenge: Challenge)
    {
        
    }
    
    func addFriend(friend: String)
    {
        //self.friends?.append(friend)
    }
    
    func removeFriend(friend: User)
    {
        
    }
    
    func sendChallenge(challenge: Challenge, friend: User)
    {
        
    }
    
    class func updateCurrentUser()
    {
        let ref = FirebaseClient.ref

        let FBID = FBSDKAccessToken.currentAccessToken().userID
        ref.child("Users").child(FBID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let friendsList = snapshot.value!["friends_list"] as! [String]
            let email = snapshot.value!["email"] as! String
            let profileImageURLString = snapshot.value!["profileImageURLString"] as! String
            
            let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, friends: friendsList)
            User.currentUser = currentUser
        })
    }
}