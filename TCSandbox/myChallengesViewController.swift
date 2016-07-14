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

class myChallengesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var challengesSegmentedControl: UISegmentedControl!
    var challengeCount: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeCount = User.currentUser?.currentChallenges?.count

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSegmentedControl(sender: AnyObject) {
        if challengesSegmentedControl.selectedSegmentIndex == 0 {
            challengeCount = User.currentUser?.currentChallenges?.count
            //reload data
        } else {
            challengeCount = User.currentUser?.pastChallenges?.count
            //reload data
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let challengeCount = challengeCount
        {
            return challengeCount
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myChallengesCell") as? myChallengeTableViewCell
        
        //cell.challengeID =
        
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
