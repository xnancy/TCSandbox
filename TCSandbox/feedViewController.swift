//
//  feedViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/20/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import MobileCoreServices

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var feedTableView: UITableView!
    
    @IBOutlet weak var noFeedTextView: UITextView!
    
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    var feedChallenges: [String]?
    var feedDictionary: [String: String]?
    var homeChallenges: [String]?
    static var toggled: DarwinBoolean?
    static var player = AVPlayer()
    static var player2 = AVPlayer()
    static let movie = AVPlayerViewController()
    static let movie2 = AVPlayerViewController()
    static var feedCellContents: [cellContents?]?
    static var homeCellContents: [cellContents?]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.hidden = false
        noFeedTextView.hidden = true
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController!.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]
        feedViewController.toggled = false
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x57C3BB)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        tabBarController?.tabBar.barTintColor = UIColor(hex: 0x57C3BB)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        feedTableView.insertSubview(refreshControl, atIndex: 0)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        queryRequest()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        feedTableView.hidden = false
        noFeedTextView.hidden = true
//        navigationController?.setNavigationBarHidden(true, animated: true)
        queryRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if feedViewController.toggled == false
        {
            if (feedChallenges == nil || feedChallenges![0] == "placeholder")
            {
                feedTableView.hidden = true
                noFeedTextView.hidden = false
                return 0
            }
            feedTableView.hidden = false
            noFeedTextView.hidden = true
            return (feedChallenges?.count)!
        }
            
        else
        {
            if (homeChallenges == nil || homeChallenges![0] == "placeholder")
            {
                feedTableView.hidden = true
                noFeedTextView.hidden = false
                return 0
            }
            feedTableView.hidden = false
            noFeedTextView.hidden = true
            return (homeChallenges?.count)!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell") as! feedTableViewCell
        
        let hasContentView: Bool = cell.subviews.contains(cell.contentView)
        if !hasContentView {
            cell.addSubview(cell.contentView)
        }
        
        if (feedViewController.toggled == false && indexPath.row%2 == 0 && feedViewController.feedCellContents![indexPath.row] != nil)
        {
            feedViewController.player = AVPlayer(URL: (feedViewController.feedCellContents![indexPath.row]?.url!)!)
            playVideo(feedViewController.player, cell: cell)
            
            self.setCellProperties(cell, contents: feedViewController.feedCellContents![indexPath.row]!, indexPathRow: indexPath.row)
        }
            
        else if (feedViewController.toggled == false && feedViewController.feedCellContents![indexPath.row] != nil)
        {
            feedViewController.player2 = AVPlayer(URL: (feedViewController.feedCellContents![indexPath.row]?.url!)!)
            playVideo(feedViewController.player2, cell: cell)
            
            self.setCellProperties(cell, contents: feedViewController.feedCellContents![indexPath.row]!, indexPathRow: indexPath.row)
        }
            
        else if (feedViewController.toggled == false)
        {
            populateCell(feedChallenges!, indexPathRow: indexPath.row, completion: { (contents) in
                feedViewController.feedCellContents![indexPath.row] = contents
                
                if (indexPath.row%2 == 0)
                {
                    feedViewController.player = AVPlayer(URL: (feedViewController.feedCellContents![indexPath.row]?.url!)!)
                    self.playVideo(feedViewController.player, cell: cell)
                }
                
                else
                {
                    feedViewController.player2 = AVPlayer(URL: (feedViewController.feedCellContents![indexPath.row]?.url!)!)
                    self.playVideo(feedViewController.player2, cell: cell)

                }
                
                self.setCellProperties(cell, contents: contents, indexPathRow: indexPath.row)
            })
        }
            
            
        else if (indexPath.row%2 == 0 && feedViewController.homeCellContents![indexPath.row] != nil)
        {
            feedViewController.player = AVPlayer(URL: (feedViewController.homeCellContents![indexPath.row]?.url!)!)
            self.playVideo(feedViewController.player, cell: cell)

            
            self.setCellProperties(cell, contents: feedViewController.homeCellContents![indexPath.row]!, indexPathRow: indexPath.row)
        }
            
        else if (feedViewController.homeCellContents![indexPath.row] != nil)
        {
            feedViewController.player2 = AVPlayer(URL: (feedViewController.homeCellContents![indexPath.row]?.url!)!)
            self.playVideo(feedViewController.player2, cell: cell)

            
            self.setCellProperties(cell, contents: feedViewController.homeCellContents![indexPath.row]!, indexPathRow: indexPath.row)
        }
            
        else
        {
            populateCell(homeChallenges!, indexPathRow: indexPath.row, completion: { (contents) in
                feedViewController.homeCellContents![indexPath.row] = contents
                
                if (indexPath.row%2 == 0)
                {
                    feedViewController.player = AVPlayer(URL: (feedViewController.homeCellContents![indexPath.row]?.url!)!)
                    self.playVideo(feedViewController.player, cell: cell)
                }
                    
                else
                {
                    feedViewController.player2 = AVPlayer(URL: (feedViewController.homeCellContents![indexPath.row]?.url!)!)
                    self.playVideo(feedViewController.player2, cell: cell)

                }
                
                self.setCellProperties(cell, contents: contents, indexPathRow: indexPath.row)
            })
        }
        
        return cell
    }
    
    func populateCell(challenges: [String], indexPathRow: Int, completion: (cellContents) -> Void)
    {
        let cellContentsToAdd: cellContents = cellContents()
        
        FBClient.retrieveChallengeFromID(challenges[indexPathRow]) { (challenge) in
            
            cellContentsToAdd.challenge = challenge
            
            cellContentsToAdd.currentParticipant = challenge.senderID
            cellContentsToAdd.participants = challenge.completedBy!
            
            var pictureArray: [String] = []
            
            for userID in challenge.completedBy!
            {
                FBClient.retrieveUserFromID(userID, completion: { (user) in
                    pictureArray.append(user.profileImageURLString!)
                })
            }
            
            cellContentsToAdd.participantPictures = pictureArray
            
            FBClient.streamVideo(challenge.challengeID!, userID: (cellContentsToAdd.currentParticipant)!, completion: {(metadata) in
                
                cellContentsToAdd.url = metadata.downloadURL()
                
                completion(cellContentsToAdd)
            })
        }
    }
    
    func setCellProperties(cell: feedTableViewCell, contents: cellContents, indexPathRow: Int)
    {
        cell.challenge = contents.challenge
        
        if (contents.currentParticipant == nil)
        {
            contents.currentParticipant = contents.challenge?.senderID
        }
        
        let index = contents.participants?.indexOf(contents.currentParticipant!)
        let videoLikes = contents.challenge!.videoLikes![index!]
        
        cell.likesLabel.text = "\(videoLikes)"
        cell.challengeNameLabel.text = contents.challenge!.name
        
        cell.currentParticipant = contents.currentParticipant
        cell.participants = contents.challenge!.completedBy!
        
        cell.profileCollectionView.reloadData()
        cell.workoutCollectionView.reloadData()
    }
    
    func playVideo(player: AVPlayer, cell: feedTableViewCell)
    {
        if player == feedViewController.player
        {
            feedViewController.movie.player = feedViewController.player
            feedViewController.movie.view.frame = cell.challengeVideoView.bounds
            cell.challengeVideoView.addSubview(feedViewController.movie.view)
        }
        
        else
        {
            feedViewController.movie2.player = feedViewController.player2
            feedViewController.movie2.view.frame = cell.challengeVideoView.bounds
            cell.challengeVideoView.addSubview(feedViewController.movie2.view)
        }
    }

    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        queryRequest()
        refreshControl.endRefreshing()
    }
    
    func queryRequest()
    {
        FBClient.retrieveFeed { (challenges, dictionary, homeChallenges) in
            
            self.feedChallenges = challenges
            self.feedDictionary = dictionary
            self.homeChallenges = homeChallenges
            feedViewController.feedCellContents = [cellContents?](count: (self.feedChallenges!.count), repeatedValue: nil)
            feedViewController.homeCellContents = [cellContents?](count: (self.homeChallenges!.count), repeatedValue: nil)
            
            //NOW DO THE SORTING
            
            self.feedChallenges?.sortInPlace({ (element1, element2) -> Bool in
                
                if FBClient.dateFormatter.dateFromString(self.feedDictionary![element1]!)?.compare(FBClient.dateFormatter.dateFromString(self.feedDictionary![element2]!)!) == NSComparisonResult.OrderedDescending
                {
                    return true
                }
                
                return false
            })
            
            self.homeChallenges?.sortInPlace({ (element1, element2) -> Bool in
                
                if FBClient.dateFormatter.dateFromString(self.feedDictionary![element1]!)?.compare(FBClient.dateFormatter.dateFromString(self.feedDictionary![element2]!)!) == NSComparisonResult.OrderedDescending
                {
                    return true
                }
                
                return false
            })
            
            for index in 0...(self.feedChallenges?.count)!-1
            {
                self.populateCell(self.feedChallenges!, indexPathRow: index, completion: { (cellContents) in
                    feedViewController.feedCellContents![index] = cellContents
                })
            }
            
            for index in 0...(self.homeChallenges?.count)!-1
            {
                self.populateCell(self.homeChallenges!, indexPathRow: index, completion: { (cellContents) in
                    feedViewController.homeCellContents![index] = cellContents
                })
            }

            self.feedTableView.reloadData()
        }
    }
    
    func toggle() {
        if feedViewController.toggled == false
        {
            feedViewController.toggled = true
            let image = UIImage(named: "group")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
            
        }
            
        else
        {
            feedViewController.toggled = false
            let image = UIImage(named: "globe")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
        }
    }
    
    @IBAction func didTouchToggle(sender: AnyObject) {
        
        if feedViewController.toggled == false
        {
            feedViewController.toggled = true
            let image = UIImage(named: "group")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
        }
        
        else
        {
            feedViewController.toggled = false
            let image = UIImage(named: "globe")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
        }
    }
    
    class func setCellContentsURL(index: Int, participant: String, completion: (NSURL) -> Void)
    {
        if (feedViewController.toggled == false)
        {
            feedViewController.feedCellContents![index]?.currentParticipant = participant
            
            //check if the url is already cached in contents.challenges.urls
            let contents = feedViewController.feedCellContents![index]
            let videoIndex = contents?.challenge?.completedBy?.indexOf(participant)
            
            if contents?.challenge?.completedBy?.indexOf(participant) != nil
            {
                if index%2 == 0
                {
                    feedViewController.player.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: (contents!.challenge?.videoURLs![videoIndex!])!)!))
                }
                
                else
                {
                    feedViewController.player2.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: (contents!.challenge?.videoURLs![videoIndex!])!)!))
                }
            }
                
            else
            {
                FBClient.streamVideo((feedViewController.feedCellContents![index]?.challenge?.challengeID)!, userID: participant, completion: { (metadata) in
                    feedViewController.feedCellContents![index]!.url = metadata.downloadURL()!
                    feedViewController.feedCellContents![index]!.currentParticipant = participant
                    completion(metadata.downloadURL()!)
                })
            }
        }
            
        else
        {
            feedViewController.homeCellContents![index]?.currentParticipant = participant
            
            let contents = feedViewController.homeCellContents![index]
            let videoIndex = contents?.challenge?.completedBy?.indexOf(participant)
            
            if contents?.challenge?.completedBy?.indexOf(participant) != nil
            {
                if index%2 == 0
                {
                    feedViewController.player.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: (contents!.challenge?.videoURLs![videoIndex!])!)!))
                }
                
                else
                {
                    feedViewController.player2.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: (contents!.challenge?.videoURLs![videoIndex!])!)!))
                }
            }
                
            else
            {
                FBClient.streamVideo((feedViewController.homeCellContents![index]?.challenge?.challengeID)!, userID: participant, completion: { (metadata) in
                    feedViewController.homeCellContents![index]!.url = metadata.downloadURL()!
                    feedViewController.homeCellContents![index]!.currentParticipant = participant
                    completion(metadata.downloadURL()!)
                })
            }
        }
    }
    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
