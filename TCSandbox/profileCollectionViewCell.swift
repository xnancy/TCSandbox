//
//  profileCollectionViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/26/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AVFoundation

class profileCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    var participant: String?
    var parentTableViewCell: feedTableViewCell?
    
    
    @IBAction func didTapCell(sender: AnyObject) {
        
        parentTableViewCell?.currentParticipant = participant
        
        let feedTableView = self.superview!.superview!.superview!.superview!.nextResponder() as! UITableView
        
        
        let index = feedTableView.indexPathForCell(parentTableViewCell!)
        
        feedViewController.setCellContentsURL((index?.row)!, participant: self.participant!, completion: {URL in
            feedTableView.reloadRowsAtIndexPaths([index!], withRowAnimation: .None)
            
            feedViewController.player.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: URL))
        })
    }
}
