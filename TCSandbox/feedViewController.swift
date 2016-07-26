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
    
    var feedChallenges: [String]?
    var feedDictionary: [String: String]?
    var homeChallenges: [String]?
    var toggled: DarwinBoolean?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
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
        //popupImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if toggled == false
        {
            if feedChallenges == nil
            {
                return 0
            }
            
            if feedChallenges![0] == "placeholder"
            {
                return 0
            }
            
            return (feedChallenges?.count)!
        }
        
        else
        {
            if homeChallenges == nil
            {
                return 0
            }
            
            if homeChallenges![0] == "placeholder"
            {
                return 0
            }
            
            return (homeChallenges?.count)!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell") as! feedTableViewCell
        
        if toggled == false
        {
            FBClient.retrieveChallengeFromID(feedChallenges![indexPath.row]) { (challenge) in
                cell.challenge = challenge
                
                if (cell.participants == nil || cell.participants![0] != challenge.senderID)
                {
                    cell.currentParticipant = challenge.senderID
                    cell.participants = challenge.completedBy!
                    cell.profileCollectionView.reloadData()
                }
                
                let index = cell.participants?.indexOf(cell.currentParticipant!)
                let videoLikes = challenge.videoLikes![index!]
                
                cell.likesLabel.text = "\(videoLikes)"
                cell.challengeNameLabel.text = challenge.name
                cell.videoLabel.text = "\((challenge.completedBy?.count)!)"
                
                FBClient.downloadVideo(challenge.challengeID!, userID: (cell.currentParticipant)!, completion: {(URL: NSURL) in
                    
                    let player = AVPlayer(URL: URL)
                    let movie = AVPlayerViewController()
                    movie.player = player
                    movie.view.frame = cell.challengeVideoView.bounds
                    
                    cell.challengeVideoView.addSubview(movie.view)
                    player.play()
                })
            }
            
            /*let gestureLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeLeft))
             gestureLeft.direction = .Left
             cell.challengeVideoView.addGestureRecognizer(gestureLeft)
             let gestureRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeRight))
             gestureRight.delegate = self
             gestureRight.direction = .Right
             cell.challengeVideoView.addGestureRecognizer(gestureRight)*/
        }
        
        else
        {
            FBClient.retrieveChallengeFromID(homeChallenges![indexPath.row]) { (challenge) in
                cell.challenge = challenge
                
                if (cell.participants == nil || cell.participants![0] != challenge.senderID)
                {
                    cell.currentParticipant = challenge.senderID
                    cell.participants = challenge.completedBy!
                    cell.profileCollectionView.reloadData()
                }
                
                let index = cell.participants?.indexOf(cell.currentParticipant!)
                let videoLikes = challenge.videoLikes![index!]
                
                cell.likesLabel.text = "\(videoLikes)"
                cell.challengeNameLabel.text = challenge.name
                cell.videoLabel.text = "\((challenge.completedBy?.count)!)"
                
                FBClient.downloadVideo(challenge.challengeID!, userID: (cell.currentParticipant)!, completion: {(URL: NSURL) in
                    
                    let player = AVPlayer(URL: URL)
                    let movie = AVPlayerViewController()
                    movie.player = player
                    movie.view.frame = cell.challengeVideoView.bounds
                    
                    cell.challengeVideoView.addSubview(movie.view)
                    player.play()
                })
            }
            
            /*let gestureLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeLeft))
             gestureLeft.direction = .Left
             cell.challengeVideoView.addGestureRecognizer(gestureLeft)
             let gestureRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeRight))
             gestureRight.delegate = self
             gestureRight.direction = .Right
             cell.challengeVideoView.addGestureRecognizer(gestureRight)*/
        }

        return cell
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
    
    
    @IBAction func didTouchToggle(sender: AnyObject) {
        
        if toggled == false
        {
            toggled = true
            
            feedTableView.reloadData()
        }
        
        else
        {
            toggled = false
            
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
