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
    var toggled: DarwinBoolean?
    var player = AVPlayer()
    var player2 = AVPlayer()
    let movie = AVPlayerViewController()
    let movie2 = AVPlayerViewController()
    var feedCellContents: [cellContents?]?
    var homeCellContents: [cellContents?]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.hidden = false
        noFeedTextView.hidden = true
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]
        
        toggled = false
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x11A9DA)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        tabBarController?.tabBar.barTintColor = UIColor(hex: 0x11A9DA)
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        queryRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if toggled == false
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
        
        if (toggled == false && indexPath.row%2 == 0 && feedCellContents![indexPath.row] != nil)
        {
            self.player = AVPlayer(URL: (feedCellContents![indexPath.row]?.url!)!)
            self.movie.player = self.player
            self.movie.view.frame = cell.challengeVideoView.bounds
            
            
            cell.challengeVideoView.addSubview(self.movie.view)
            self.player.play()
            
            let index = feedCellContents![indexPath.row]!.participants?.indexOf(feedCellContents![indexPath.row]!.currentParticipant!)
            let videoLikes = feedCellContents![indexPath.row]!.challenge!.videoLikes![index!]
            
            cell.likesLabel.text = "\(videoLikes)"
            cell.challengeNameLabel.text = feedCellContents![indexPath.row]!.challenge!.name
            
            cell.currentParticipant = feedCellContents![indexPath.row]!.challenge!.senderID
            cell.participants = feedCellContents![indexPath.row]!.challenge!.completedBy!
            
            cell.profileCollectionView.reloadData()
            cell.workoutCollectionView.reloadData()
        }
            
        else if (toggled == false && feedCellContents![indexPath.row] != nil)
        {
            self.player2 = AVPlayer(URL: (feedCellContents![indexPath.row]?.url!)!)
            self.movie2.player = self.player2
            self.movie2.view.frame = cell.challengeVideoView.bounds
            
            
            cell.challengeVideoView.addSubview(self.movie2.view)
            self.player2.play()
            
            let index = feedCellContents![indexPath.row]!.participants?.indexOf(feedCellContents![indexPath.row]!.currentParticipant!)
            let videoLikes = feedCellContents![indexPath.row]!.challenge!.videoLikes![index!]
            
            cell.likesLabel.text = "\(videoLikes)"
            cell.challengeNameLabel.text = feedCellContents![indexPath.row]!.challenge!.name
            
            cell.currentParticipant = feedCellContents![indexPath.row]!.challenge!.senderID
            cell.participants = feedCellContents![indexPath.row]!.challenge!.completedBy!
            
            cell.profileCollectionView.reloadData()
            cell.workoutCollectionView.reloadData()
        }
            
        else if (toggled == false)
        {
            populateCell(feedChallenges!, indexPathRow: indexPath.row, completion: { (contents) in
                self.feedCellContents![indexPath.row] = contents
                cell.profileCollectionView.reloadData()
                cell.workoutCollectionView.reloadData()
                
                if (indexPath.row%2 == 0)
                {
                    self.player = AVPlayer(URL: (self.feedCellContents![indexPath.row]?.url!)!)
                    self.movie.player = self.player
                    self.movie.view.frame = cell.challengeVideoView.bounds
                    
                    
                    cell.challengeVideoView.addSubview(self.movie.view)
                    self.player.play()
                }
                
                else
                {
                    self.player2 = AVPlayer(URL: (self.feedCellContents![indexPath.row]?.url!)!)
                    self.movie2.player = self.player2
                    self.movie2.view.frame = cell.challengeVideoView.bounds
                    
                    
                    cell.challengeVideoView.addSubview(self.movie2.view)
                    self.player2.play()
                }
                
                let index = contents.participants?.indexOf(contents.currentParticipant!)
                let videoLikes = contents.challenge!.videoLikes![index!]
                
                cell.likesLabel.text = "\(videoLikes)"
                cell.challengeNameLabel.text = contents.challenge!.name
                
                cell.currentParticipant = contents.challenge!.senderID
                cell.participants = contents.challenge!.completedBy!
                
                cell.profileCollectionView.reloadData()
                cell.workoutCollectionView.reloadData()
            })
        }
            
            
        else if (indexPath.row%2 == 0 && homeCellContents![indexPath.row] != nil)
        {
            self.player = AVPlayer(URL: (homeCellContents![indexPath.row]?.url!)!)
            self.movie.player = self.player
            self.movie.view.frame = cell.challengeVideoView.bounds
            
            
            cell.challengeVideoView.addSubview(self.movie.view)
            self.player.play()
            
            let index = homeCellContents![indexPath.row]!.participants?.indexOf(homeCellContents![indexPath.row]!.currentParticipant!)
            let videoLikes = homeCellContents![indexPath.row]!.challenge!.videoLikes![index!]
            
            cell.likesLabel.text = "\(videoLikes)"
            cell.challengeNameLabel.text = homeCellContents![indexPath.row]!.challenge!.name
            
            cell.currentParticipant = homeCellContents![indexPath.row]!.challenge!.senderID
            cell.participants = homeCellContents![indexPath.row]!.challenge!.completedBy!
            
            cell.profileCollectionView.reloadData()
            cell.workoutCollectionView.reloadData()
        }
            
        else if (homeCellContents![indexPath.row] != nil)
        {
            self.player2 = AVPlayer(URL: (homeCellContents![indexPath.row]?.url!)!)
            self.movie2.player = self.player2
            self.movie2.view.frame = cell.challengeVideoView.bounds
            
            
            cell.challengeVideoView.addSubview(self.movie2.view)
            self.player2.play()
            
            let index = homeCellContents![indexPath.row]!.participants?.indexOf(homeCellContents![indexPath.row]!.currentParticipant!)
            let videoLikes = homeCellContents![indexPath.row]!.challenge!.videoLikes![index!]
            
            cell.likesLabel.text = "\(videoLikes)"
            cell.challengeNameLabel.text = homeCellContents![indexPath.row]!.challenge!.name
            
            cell.currentParticipant = homeCellContents![indexPath.row]!.challenge!.senderID
            cell.participants = homeCellContents![indexPath.row]!.challenge!.completedBy!
            
            cell.profileCollectionView.reloadData()
            cell.workoutCollectionView.reloadData()
        }
            
        else
        {
            populateCell(homeChallenges!, indexPathRow: indexPath.row, completion: { (contents) in
                self.homeCellContents![indexPath.row] = contents
                
                if (indexPath.row%2 == 0)
                {
                    self.player = AVPlayer(URL: (self.homeCellContents![indexPath.row]?.url!)!)
                    self.movie.player = self.player
                    self.movie.view.frame = cell.challengeVideoView.bounds
                    
                    
                    cell.challengeVideoView.addSubview(self.movie.view)
                    self.player.play()
                }
                    
                else
                {
                    self.player2 = AVPlayer(URL: (self.homeCellContents![indexPath.row]?.url!)!)
                    self.movie2.player = self.player2
                    self.movie2.view.frame = cell.challengeVideoView.bounds
                    
                    
                    cell.challengeVideoView.addSubview(self.movie2.view)
                    self.player2.play()
                }
                
                let index = contents.participants?.indexOf(contents.currentParticipant!)
                let videoLikes = contents.challenge!.videoLikes![index!]
                
                cell.likesLabel.text = "\(videoLikes)"
                cell.challengeNameLabel.text = contents.challenge!.name
                
                cell.currentParticipant = contents.challenge!.senderID
                cell.participants = contents.challenge!.completedBy!
                
                cell.profileCollectionView.reloadData()
                cell.workoutCollectionView.reloadData()
            })
        }
        
        
        
        if toggled == false && indexPath.row + 1 < feedChallenges?.count
        {
            populateCell(feedChallenges!, indexPathRow: indexPath.row+1, completion: { (contents) in
                self.feedCellContents![indexPath.row + 1] = contents
            })
        }
            
        else if indexPath.row + 1 < homeChallenges?.count
        {
            populateCell(homeChallenges!, indexPathRow: indexPath.row+1, completion: { (contents) in
                self.homeCellContents![indexPath.row + 1] = contents
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
            
            FBClient.downloadVideo(challenge.challengeID!, userID: (cellContentsToAdd.currentParticipant)!, completion: {(URL: NSURL) in
                
                cellContentsToAdd.url = URL
                
                completion(cellContentsToAdd)
            })
        }
    }
    

    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        
        queryRequest()
        refreshControl.endRefreshing()
    }
    
    func queryRequest()
    {
        FBClient.retrieveFeed { (challenges, dictionary, homeChallenges) in
            self.feedChallenges = challenges
            self.feedDictionary = dictionary
            self.homeChallenges = homeChallenges
            self.feedCellContents = [cellContents?](count: (self.feedChallenges!.count), repeatedValue: nil)
            self.homeCellContents = [cellContents?](count: (self.homeChallenges!.count), repeatedValue: nil)
            
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
            
            //sort out the correct dates here

            self.feedTableView.reloadData()
        }
    }
    
    
    func handleSwipeLeft(gestureRecognizer: UISwipeGestureRecognizer) {
        let point: CGPoint = gestureRecognizer.locationInView(self.feedTableView)
        let indexPath: NSIndexPath = self.feedTableView.indexPathForRowAtPoint(point)!
        // Action...
        // Action...
        let cell = feedTableView.cellForRowAtIndexPath(indexPath) as! feedTableViewCell
        
        let currentIndex = cell.participants?.indexOf(cell.currentParticipant!)
        
        if currentIndex == 0
        {
            cell.currentParticipant = cell.participants![(cell.participants?.count)!-1]
        }
        
        else
        {
            cell.currentParticipant = cell.participants![currentIndex!-1]
        }
        
        feedTableView.reloadData()
    }
    
    
    func handleSwipeRight(gestureRecognizer: UISwipeGestureRecognizer) {
        let point: CGPoint = gestureRecognizer.locationInView(self.feedTableView)
        let indexPath: NSIndexPath = self.feedTableView.indexPathForRowAtPoint(point)!
        // Action...
        // Action...
        let cell = feedTableView.cellForRowAtIndexPath(indexPath) as! feedTableViewCell
        
        let currentIndex = cell.participants?.indexOf(cell.currentParticipant!)
        
        if currentIndex! == (cell.participants?.count)!-1
        {
            cell.currentParticipant = cell.participants![0]
        }
        
        else
        {
            cell.currentParticipant = cell.participants![currentIndex!+1]
        }
        
        feedTableView.reloadData()
    }
    
    func toggle() {
        if toggled == false
        {
            toggled = true
            let image = UIImage(named: "group")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
            
        }
            
        else
        {
            toggled = false
            let image = UIImage(named: "globe")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
        }
    }
    
    @IBAction func didTouchToggle(sender: AnyObject) {
        
        if toggled == false
        {
            toggled = true
            let image = UIImage(named: "group")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
        }
        
        else
        {
            toggled = false
            let image = UIImage(named: "globe")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(toggle))
            feedTableView.reloadData()
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
