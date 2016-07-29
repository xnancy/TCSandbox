//
//  detailsTableViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/18/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import QuartzCore

class detailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    var gifName: String?
    
    @IBOutlet weak var cTagTextLable: UILabel!

    @IBOutlet weak var cTagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cTagImageView.hidden = true
        cTagTextLable.hidden = true
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 4
        layer.borderColor = UIColor(white: 0x000000, alpha: 0).CGColor
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.init(hex: 0x11A9DA)
        selectedBackgroundView = bgColorView
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        exerciseLabel.textColor = UIColor.blackColor()
    }
}
