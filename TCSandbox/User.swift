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
    
    // array of user IDs
    var friends: [String]?
    
    // array of current challenges
    var currentChallenges: [String]?

    // array of past challenges
    var pastChallenges: [String]?
    
    static var currentUser: User?
 
    /* ---------- INITIALIZERS ---------- */
    // Empty initializer
    init() {
        FBID = "."
        profileImageURLString = ""
        email = ""
        friends = []
        currentChallenges = []
        pastChallenges = []
    }
 
    // Create user object from Firebase dictionary
    init(dict: NSDictionary)
    {
        self.FBID = dict["id"] as! String
        self.email = dict["email"] as! String
        self.profileImageURLString = dict["profile_picutre_url"] as! String
        self.friends = dict["friends_list"] as! [String]
        self.currentChallenges = []
        self.pastChallenges = []
    }
    
    init(FBID: String, email: String, profileImageURLString: String) {
        self.FBID = FBID
        self.email = email
        self.profileImageURLString = profileImageURLString
        self.friends = friends
        self.currentChallenges = []
        self.pastChallenges = []
    }
    
    class func logout()
    {
        User.currentUser = nil
        FBClient.logout()
    }
    
    func upload(challenge: Challenge)
    {
        
    }
    
    func remove(challenge: Challenge)
    {
        
    }
    
    func addFriend(friendID: String)
    {
        self.friends?.append(friendID)
    }
    
    func removeFriend(friend: User)
    {
        
    }
    
    func sendChallenge(challenge: Challenge, friend: User)
    {
        
    }
    
    class func updateCurrentUser()
    {
        let ref = FBClient.ref

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
