//
//  FriendsSendChallengeTableViewCell.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/12/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import Foundation

class FriendsSendChallengeTableViewCell: UITableViewCell {
    
    /* ---------- OUTLETS ---------- */
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userChallengeCompletedLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var userID: String?
    
}

