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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateChallengeInfo()
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
            return (pastChallenges?.count)!
        } else {
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

    /*  ---------- SEGUES ---------- */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("reached 0")
        if (segue.identifier == "toChallengeDetailPage") {
            print("reached 00")
            let vc = segue.destinationViewController as! ChallengeDetailViewController
            print("reached 000")
            vc.challenge = (sender as! myChallengeTableViewCell).challenge
            print("reached 0000")
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
