//
//  myChallengeTableViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/14/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class myChallengeTableViewCell: UITableViewCell {
    
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var deadlineProgressView: UIProgressView!
    
    /* ---------- VARIABLES ---------- */
    var challenge: Challenge?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
