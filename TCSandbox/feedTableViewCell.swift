//
//  feedTableViewCell.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/20/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SwiftyGif

class feedTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var challenge: Challenge?
    var participants: [String]?
    var participantPictures:[String]?
    var currentParticipant: String?
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    
    @IBOutlet weak var currentName: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeVideoView: UIView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var loadingImageView: UIImageView!
   
    
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var workoutCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8)
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        workoutCollectionView.delegate = self
        workoutCollectionView.dataSource = self
        loadingImageView.setGifImage(UIImage(gifName: "loadinggif"), manager: gifManager, loopCount: 1)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Clear contentView
        let hasContentView: Bool = self.subviews.contains((self.contentView))
        if hasContentView {
            self.contentView.removeFromSuperview()
        }
    }
    
    @IBAction func didTapLike(sender: AnyObject) {
        let index = participants?.indexOf(currentParticipant!)!
        let feedTableView: UITableView = (self.superview!.superview as! UITableView)
        let cellIndex = feedTableView.indexPathForCell(self)
        
        FBClient.tappedLike(currentParticipant!, challengeID: (challenge?.challengeID)!, videoURL: (challenge?.videoURLs![index!])!, index: index!, completion: {(hasLiked) in
            
            if hasLiked && feedViewController.toggled == false
            {
                self.likesLabel.text = "\(Int(self.likesLabel.text!)! - 1)"
                feedViewController.feedCellContents![(cellIndex?.row)!]!.challenge!.videoLikes![index!] -= 1
            }
                
            else if feedViewController.toggled == false
            {
                self.likesLabel.text = "\(Int(self.likesLabel.text!)! + 1)"
                feedViewController.feedCellContents![(cellIndex?.row)!]!.challenge!.videoLikes![index!] += 1
            }
            
            else if hasLiked
            {
                self.likesLabel.text = "\(Int(self.likesLabel.text!)! - 1)"
                feedViewController.homeCellContents![(cellIndex?.row)!]!.challenge!.videoLikes![index!] -= 1
            }
            
            else
            {
                self.likesLabel.text = "\(Int(self.likesLabel.text!)! + 1)"
                feedViewController.homeCellContents![(cellIndex?.row)!]!.challenge!.videoLikes![index!] += 1
            }
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workoutCollectionView
        {
            if challenge == nil
            {
                return 0
            }
            
            if (challenge?.tagNames![0] != "placeholder") //gif will always have something, so not necessary to check this for gifs as well
            {
                return (challenge?.gifNames?.count)! + (challenge?.tagNames?.count)!
            }
            
            return (challenge?.gifNames?.count)!
        }
        
        if participants == nil
        {
            return 0
        }
        
        return (participants?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == workoutCollectionView
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("workoutCell", forIndexPath: indexPath) as! workoutCollectionViewCell
            
            if challenge?.gifNames!.count > indexPath.row
            {
                cell.workoutLabel.text = Gifs.gifDictionary[(challenge?.gifNames![indexPath.row])!]
            }
                
            else if challenge?.tagNames?.count > indexPath.row - (challenge?.gifNames?.count)!
            {
                cell.workoutLabel.text = Tags.tagDictionary[(challenge?.tagNames![indexPath.row-(challenge?.gifNames?.count)!])!]
            }
            cell.layer.cornerRadius = 6
            return cell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) as! profileCollectionViewCell
        
        
        cell.parentTableViewCell = self
        cell.participant = participants![indexPath.row]
        
        FBClient.retrievePictureForUser(participants![indexPath.row]) { (URL) in
            
            cell.profileImageView.setImageWithURL(NSURL(string: URL)!)
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height/2
            cell.profileImageView.clipsToBounds = true
        }
        
        return cell
    }
}
