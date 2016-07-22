//
//  myChallengesViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/14/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import Foundation

class myChallengesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var challengesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var myChallengesTableView: UITableView!
    var currentChallenges: [Challenge]?
    var pastChallenges: [Challenge]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myChallengesTableView.delegate = self
        myChallengesTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        myChallengesTableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        currentChallenges = []
        pastChallenges = []
        updateChallengeInfo()
        self.tabBarController?.tabBar.hidden = false
    }

    func updateChallengeInfo() {
        currentChallenges = []
        pastChallenges = []
        var allChallenges: [Challenge]? = []
        let currentDate = NSDate()
        
        FBClient.retrieveChallenges { (challenges: [Challenge]) in
            // Get [Challenge] of user challenges
            for challenge in challenges {
                allChallenges?.append(challenge)
            }
            // Split by past / current
            for challenge in allChallenges! {
                if (challenge.deadline?.compare(currentDate) == NSComparisonResult.OrderedAscending) {
                    self.pastChallenges?.append(challenge)
                } else {
                    self.currentChallenges?.append(challenge)
                }
            }
            self.myChallengesTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ---------- ACTIONS ---------- */
    @IBAction func onSegmentedControl(sender: AnyObject) {
        myChallengesTableView.reloadData()
    }
    
    /* ---------- TABLE VIEW ---------- */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (challengesSegmentedControl.selectedSegmentIndex == 1) {
            if (pastChallenges == nil) { return 0 }
            return (pastChallenges?.count)!
        } else {
            if (currentChallenges == nil) { return 0 }
            return (currentChallenges?.count)!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myChallengesCell") as? myChallengeTableViewCell
        if (challengesSegmentedControl.selectedSegmentIndex == 1) {
            cell?.challenge = pastChallenges![indexPath.row]
            FBClient.generateChallengeCell(pastChallenges![indexPath.row], cell: cell!)
        } else {
            cell?.challenge = currentChallenges![indexPath.row]
            FBClient.generateChallengeCell(currentChallenges![indexPath.row], cell: cell!)
        }
        return cell!
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if (challengesSegmentedControl.selectedSegmentIndex == 1) {
                FBClient.declineChallenge(pastChallenges![indexPath.row])
                pastChallenges?.removeAtIndex(indexPath.row)
            } else {
                FBClient.declineChallenge(currentChallenges![indexPath.row])
                currentChallenges?.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Decline"
    }
    /*  ---------- SEGUES ---------- */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if (segue.identifier == "toChallengeDetailPage") {
            let vc = segue.destinationViewController as! ChallengeDetailViewController
            vc.challenge = (sender as! myChallengeTableViewCell).challenge
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        
        updateChallengeInfo()
        refreshControl.endRefreshing()
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
