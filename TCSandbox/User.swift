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
    var profileImageURL: NSURL?
    var email: String?
    var friends: [User]?
    var currentChallenges: [Challenge]?
    
 
    init(FBID: String?, email: String?, profileImageURL: NSURL?)
    {
        self.FBID = FBID
        self.email = email
        self.profileImageURL = profileImageURL
    }
    
    static var currentUser: User?
    
    
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
            let profileImageURL = NSURL(fileURLWithPath: pictureUrl)
            
            
            User.currentUser = User(FBID: FBID, email: email, profileImageURL: profileImageURL)
        })
    }
}