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
    
    @IBOutlet weak var myChallengesTableView: UITableView!
    @IBOutlet weak var makeChallengePromptTextLabel: UITextView!
    
    var currentChallenges: [Challenge]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x11A9DA)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]

        tabBarController?.tabBar.barTintColor = UIColor(hex: 0x11A9DA)
        myChallengesTableView.delegate = self
        myChallengesTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        myChallengesTableView.insertSubview(refreshControl, atIndex: 0)
        myChallengesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        currentChallenges = []
        updateChallengeInfo()
        self.tabBarController?.tabBar.hidden = false
    }
    
    func updateChallengeInfo() {
        var allChallenges: [Challenge]? = []
        let currentDate = NSDate()
        
        FBClient.retrieveChallenges { (challenges: [Challenge]) in
            var currentChallenges: [Challenge]? = []
            // Get challenges not responded to
            for challenge in challenges {
                if (!(challenge.completedBy?.contains(FBSDKAccessToken.currentAccessToken().userID))! && !(challenge.deadline?.compare(currentDate) == NSComparisonResult.OrderedAscending)) {
                    currentChallenges!.append(challenge)
                }
            }
            self.currentChallenges = currentChallenges
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
        if (currentChallenges == nil || currentChallenges?.count == 0) {
            tableView.hidden = true
            makeChallengePromptTextLabel.hidden = false
            return 0
        }
        tableView.hidden = false
        makeChallengePromptTextLabel.hidden = true
        return (currentChallenges?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myChallengesCell") as? myChallengeTableViewCell
        cell?.challenge = currentChallenges![indexPath.row]
        FBClient.generateChallengeCell(currentChallenges![indexPath.row], cell: cell!)
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            FBClient.declineChallenge(currentChallenges![indexPath.row])
            currentChallenges?.removeAtIndex(indexPath.row)
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
