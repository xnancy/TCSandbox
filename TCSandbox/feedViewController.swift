//
//  feedViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/20/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import MobileCoreServices

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedTableView: UITableView!
    var feedChallenges: [String]?
    var feedDictionary: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        
        FBClient.retrieveFeed { (challenges, dictionary) in
            self.feedChallenges = challenges
            self.feedDictionary = dictionary
            print(challenges)
            print(dictionary)
            
            //NOW DO THE SORTING
            
            self.feedChallenges?.sortInPlace({ (element1, element2) -> Bool in
                print(element1)
                print(element2)
                if FBClient.dateFormatter.dateFromString(self.feedDictionary![element1]!)?.compare(FBClient.dateFormatter.dateFromString(self.feedDictionary![element2]!)!) == NSComparisonResult.OrderedDescending
                {
                    return true
                }
                
                return false
            })
            
            self.feedTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feedChallenges == nil
        {
            return 0
        }
        
        return (feedChallenges?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell") as! feedTableViewCell
        
        FBClient.retrieveChallengeFromID(feedChallenges![indexPath.row]) { (challenge) in
            cell.challenge = challenge
            
            cell.challengeNameLabel.text = challenge.name
            
            FBClient.downloadVideo(challenge.challengeID!, userID: (challenge.senderID)!, completion: {(URL: NSURL) in
                
                let player = AVPlayer(URL: URL)
                let movie = AVPlayerViewController()
                movie.player = player
                movie.view.frame = cell.challengeVideoView.bounds
                
                cell.challengeVideoView.addSubview(movie.view)
                player.play()
            })
        }
        
        return cell
    }
    
    
    @IBAction func didTapLogout(sender: AnyObject) {
        
        FBClient.logout()
        
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
