//
//  WorkoutEditorTableViewCell.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class WorkoutEditorTableViewCell: UITableViewCell {

    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var repetitionQuantityLabel: UILabel!
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
