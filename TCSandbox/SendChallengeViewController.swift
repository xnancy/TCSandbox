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

class SendChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var friendsSendChallengeTableView: UITableView!
    
    /* ---------- VARIABLES ---------- */
    var friendIDs: [String]?
    var challenge: Challenge?
    
    /* ---------- VIEW CONTROLLERS ---------- */
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        FBClient.generateFriendCell(friendIDs![indexPath.row], cell: cell)
        cell.userID = friendIDs![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (friendIDs == nil) { return 0 }
        return friendIDs!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = friendsSendChallengeTableView.cellForRowAtIndexPath(indexPath) as! FriendsSendChallengeTableViewCell
        
        if (((challenge?.participants?.contains(cell.userID!))) == nil) {
            challenge?.removeParticipant(cell.userID!)
        } else {
            challenge?.addParticipant(cell.userID!)
        }
    }
    
    
    @IBAction func didSendChallenge(sender: AnyObject) {
        //add gifnames
        //add tagnames

        FBClient.uploadChallenge(challenge!)
    }
    
    /* ---------- GESTURE RECOGNIZERS ---------- */
    
}
