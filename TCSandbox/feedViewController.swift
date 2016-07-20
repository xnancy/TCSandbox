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
    var feedDictionary: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //change this later
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell") as! feedTableViewCell
        
        FBClient.retrieveChallengeFromID("-KN9IraZxMscisQQ-F-6") { (challenge) in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
