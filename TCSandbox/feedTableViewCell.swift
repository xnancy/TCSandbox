//
//  feedTableViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/20/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class feedTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var challenge: Challenge?
    var participants: [String]?
    var participantPictures:[String]?
    var currentParticipant: String?
    
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeVideoView: UIView!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    @IBOutlet weak var profileCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if participants == nil
        {
            return 0
        }
        
        return (participants?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) as! profileCollectionViewCell
        
         var url = ""
        
         FBClient.retrievePictureForUser(participants![indexPath.row]) { (URL) in
            
            url = URL
            cell.profileImageView.setImageWithURL(NSURL(string: url)!)
        }
        
        return cell
    }
    
}
