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

class User: AnyObject {
    var FBID: String?
    var profileImageURLString: String?
    var email: String?
    var friends: [User]?
    var currentChallenges: [Challenge]?
    var pastChallenges: [Challenge]?
    
    static var currentUser: User?
    
 
    init(FBID: String?, email: String?, profileImageURLString: String?)
    {
        self.FBID = FBID
        self.email = email
        self.profileImageURLString = profileImageURLString
        self.friends = []
        self.currentChallenges = []
    }
    
    
    func upload(challenge: Challenge)
    {
        
    }
    
    func remove(challenge: Challenge)
    {
        
    }
    
    func addFriend(friend: User)
    {
        self.friends?.append(friend)
    }
    
    func removeFriend(friend: User)
    {
        
    }
    
    func sendChallenge(challenge: Challenge, friend: User)
    {
        
    }
    
    
    
    class func updateCurrentUser()
    {
        let parameters = ["fields": "email, name, id, picture.type(large)"]
        let request = FBSDKGraphRequest(graphPath: "me", parameters: parameters, tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
        
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
            
            
            User.currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString)
        })
    }
}