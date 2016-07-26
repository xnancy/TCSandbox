//
//  feedTableViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/20/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class feedTableViewCell: UITableViewCell {
    
    var challenge: Challenge?
    var participants: [String]?
    var currentParticipant: String?
    
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeVideoView: UIView!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapLike(sender: AnyObject) {
        let index = participants?.indexOf(currentParticipant!)!
        
        FBClient.tappedLike(currentParticipant!, challengeID: (challenge?.challengeID)!, videoURL: (challenge?.videoURLs![index!])!, index: index!, completion: {(hasLiked) in
            
            if hasLiked
            {
                self.likesLabel.text = "\(Int(self.likesLabel.text!)! - 1)"
            }
                
            else
            {
                self.likesLabel.text = "\(Int(self.likesLabel.text!)! + 1)"
            }
        })
    }
    
}
