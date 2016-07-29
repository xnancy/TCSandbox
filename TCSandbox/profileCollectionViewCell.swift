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
        let participantIndex = self.parentTableViewCell?.challenge?.completedBy?.indexOf(participant!)
        
        FBClient.retrieveUserFromID(participant!, completion: { (user) in
            
            self.parentTableViewCell?.currentName.text = user.name
        })
        
        parentTableViewCell?.likesLabel.text = "\((feedViewController.feedCellContents![(index?.row)!]!.challenge?.videoLikes![participantIndex!])!)"
        
        if (index?.row)!%2 == 0
        {
            feedViewController.setCellContentsURL((index?.row)!, participant: self.participant!, completion: {URL in
            feedViewController.videoController1.setVideo(URL)
            })
        }
        
        else
        {
            feedViewController.setCellContentsURL((index?.row)!, participant: self.participant!, completion: {URL in
            feedViewController.videoController2.setVideo(URL)
            })
        }
    }
    
    override func prepareForReuse() {
        profileImageView.image = nil
        participant = nil
        parentTableViewCell = nil
    }
}
