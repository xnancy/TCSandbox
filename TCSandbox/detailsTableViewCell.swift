//
//  detailsTableViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/18/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class detailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
