//
//  User.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/7/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation

class User: AnyObject {
    var FBID: String?
    var profileImageURL: NSURL?
    var email: String?
    var friends: [User]?
    var currentChallenges: [Challenge]?
}