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
        updateChallengeInfo()
        print("View did load RUN")
    }

    func updateChallengeInfo() {
        
        currentChallenges = []
        pastChallenges = []
        var allChallenges: [Challenge]?
        let currentDate = NSDate()
        
        FBClient.retrieveChallenges { (challenges: [Challenge]) in
            print("RETRIEVING")
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
            print("number of challenges: \(self.currentChallenges?.count), \(self.pastChallenges?.count)")
            self.myChallengesTableView.reloadData()
        }
        print("UPDATE CHALLENGES RUN DONE")
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
            cell?.senderNameLabel.text = pastChallenges![indexPath.row].senderID
            cell?.challengeNameLabel.text = pastChallenges![indexPath.row].name
            cell?.timeLimitLabel.text = String(pastChallenges![indexPath.row].timeLimit)
        }
        return cell!
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
