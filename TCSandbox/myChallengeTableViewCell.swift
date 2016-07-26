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
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var textBackgroundView: UIView!
    
    /* ---------- VARIABLES ---------- */
    var challenge: Challenge?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.deadlineProgressView.layer.cornerRadius = 4
        self.deadlineProgressView.clipsToBounds = true
        
        self.textBackgroundView.layer.cornerRadius = 10
        self.textBackgroundView.clipsToBounds = true

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
