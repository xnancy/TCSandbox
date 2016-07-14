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
    
    /* ---------- VIEW CONTROLLERS ---------- */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsSendChallengeTableView.delegate = self
        friendsSendChallengeTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        FBClient.updateFriends(User.currentUser!)
        friendIDs = User.currentUser?.friends
        print(friendIDs)
        friendsSendChallengeTableView.reloadData()
    }
    
    /* ---------- TABLE VIEW DATA SOURCE ---------- */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(friendIDs)
        let cell = friendsSendChallengeTableView.dequeueReusableCellWithIdentifier("friendsCell") as! FriendsSendChallengeTableViewCell
        FBClient.generateFriendCell(friendIDs![indexPath.row], cell: cell)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendIDs!.count
    }
}