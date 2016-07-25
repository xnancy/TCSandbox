//
//  SendChallengeViewController.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/11/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking
import AVKit
import MediaPlayer
import MobileCoreServices

class SendChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var friendsSendChallengeTableView: UITableView!
    @IBOutlet weak var confirmationImageView: UIImageView!
    /* ---------- VARIABLES ---------- */
    var friendIDs: [String]?
    var challenge: Challenge?
    var pickedVideo: NSURL?
    
    /* ---------- VIEW CONTROLLERS ---------- */
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        // Remove back button bar name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.friendsSendChallengeTableView.delegate = self
        self.friendsSendChallengeTableView.dataSource = self
        self.friendsSendChallengeTableView.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(animated: Bool) {
        FBClient.updateFriends(User.currentUser!, completion: {(friendsArray: [String]) in
            User.currentUser?.friends = friendsArray
            self.friendIDs = friendsArray
            
            self.friendsSendChallengeTableView.reloadData()
        })
    }
    
    /* ---------- TABLE VIEW DATA SOURCE ---------- */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = friendsSendChallengeTableView.dequeueReusableCellWithIdentifier("friendsCell") as! FriendsSendChallengeTableViewCell
        FBClient.generateFriendCell(friendIDs![indexPath.row + 1], cell: cell)
        cell.userID = friendIDs![indexPath.row + 1]
        return cell
    }
    
    func popupImage() {
        confirmationImageView.hidden = false
        confirmationImageView.alpha = 1.0
        // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
        UIView.animateWithDuration(1.0, delay: 1.0, options: [], animations: {() -> Void in
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            self.confirmationImageView.alpha = 0.0
            }, completion: {(finished: Bool) -> Void in
                // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
                self.confirmationImageView.hidden = true
        })
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (friendIDs == nil) { return 0 }
        return friendIDs!.count - 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = friendsSendChallengeTableView.cellForRowAtIndexPath(indexPath) as! FriendsSendChallengeTableViewCell
        
        challenge?.addParticipant(cell.userID!)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = friendsSendChallengeTableView.cellForRowAtIndexPath(indexPath) as! FriendsSendChallengeTableViewCell
        challenge?.removeParticipant(cell.userID!)
    }
    
    
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    @IBAction func didSendChallenge(sender: AnyObject) {
        //ADD GIF NAMES
        //ADD TAG NAMES
        //ADD CHALLENGE NAME
        if (challenge?.participants)! == []
        {
            //SEND A NOTIFICATION THAT THEY NEED TO SELECT PARTICIPANTS!
        }

            else
        {
            FBClient.uploadChallenge(challenge!)
            FBClient.uploadVideo(pickedVideo!, challenge: challenge!)
            
            
            let homeViewController: UIViewController = storyboard!.instantiateViewControllerWithIdentifier("initialViewController")
            
            popupImage()
            
            delay(1.7){
           self.presentViewController(homeViewController, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true) {
        }
    }
    /* ---------- GESTURE RECOGNIZERS ---------- */
    
}
