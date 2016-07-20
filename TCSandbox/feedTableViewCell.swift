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
    
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeVideoView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
