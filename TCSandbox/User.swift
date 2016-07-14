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
    var name: String?
    var profileImageURLString: String?
    var email: String?
    var friends: [String]? = [] {
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue)
        }
    }
    
    var challengesCompleted: Int
    var currentChallenges: [String]?
    var pastChallenges: [String]?
    
    static var currentUser: User?
    
    /* ---------- INITIALIZERS ---------- */
    // Empty initializer
    init() {
        FBID = "."
        profileImageURLString = ""
        email = ""
        name = ""
        friends = []
        currentChallenges = []
        pastChallenges = []
        challengesCompleted = 0
    }
    
    // Create user object from Firebase dictionary
    init(dict: NSDictionary)
    {
        self.FBID = dict["FBID"] as! String
        self.email = dict["email"] as! String
        self.name = dict["name"] as! String
        self.profileImageURLString = dict["profile_picture_url"] as! String
        self.friends = dict["friends_list"] as! [String]
        self.currentChallenges = dict["current_challenges"] as! [String]
        self.pastChallenges = dict["past_challenges"] as! [String]
        self.challengesCompleted = dict["challenges_completed"] as! Int
    }
    
    // Create new user object from FB
    init(FBID: String, email: String, profileImageURLString: String, name: String, friends: [String]) {
        self.FBID = FBID
        self.email = email
        self.name = name
        self.profileImageURLString = profileImageURLString
        self.friends = []
        self.currentChallenges = []
        self.pastChallenges = []
        self.challengesCompleted = 0
    }
    
    func declineChallenge(challenge: Challenge)
    {
        FBClient.declineChallenge(challenge)
    }
    
    func addFriend(friendID: String)
    {
        FBClient.addFriend(friendID)
    }
    
    func removeFriend(friendID: String)
    {
        FBClient.removeFriend(friendID)
    }

    class func updateCurrentUser()
    {
        let ref = FBClient.dataRef
        
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        ref.child("Users").child(FBID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let friendsList = snapshot.value!["friends_list"] as! [String]
            let email = snapshot.value!["email"] as! String
            let profileImageURLString = snapshot.value!["profile_picture_url"] as! String
            let name = snapshot.value!["name"] as! String
            
            let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, name: name, friends: friendsList)
            User.currentUser = currentUser
        })
    }
}
