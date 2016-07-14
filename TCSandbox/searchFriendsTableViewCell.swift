//
//  searchFriendsTableViewCell.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/13/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class searchFriendsTableViewCell: UITableViewCell {
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var challengesCompletedLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    /* ---------- VARIABLES ---------- */
    var userID: String?
    
    /* ---------- ACTIONS ---------- */
    @IBAction func onAddFriendButton(sender: AnyObject) {
        FBClient.addFriend(userID!)
        addButton.enabled = false
    }
    
    
}

