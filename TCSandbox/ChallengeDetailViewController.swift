//
//  ChallengeDetailViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/18/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import AVKit
import MediaPlayer

class ChallengeDetailViewController: UIViewController {
    
    var challenge: Challenge?
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        
        
        challengeTitleLabel.text = challenge?.challengeTitle
        deadlineLabel.text = challenge?.dateToString()
        let sender = FBClient.getUser((challenge?.senderID)!)
        let profileURL = NSURL(string: sender.profileImageURLString!)
        profileImageView.setImageWithURL(profileURL!)
        
        FBClient.downloadVideo((challenge?.challengeID)!, userID: (challenge?.senderID)!, completion: {(URL: NSURL) in
            
            let player = AVPlayer(URL: URL)
            let movie = AVPlayerViewController()
            movie.player = player
            movie.view.frame = self.videoView.bounds
            
            self.view.addSubview(movie.view)
            player.play()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
