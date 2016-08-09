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
import SwiftyGif

class myChallengesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myChallengesTableView: UITableView!
    @IBOutlet weak var makeChallengePromptTextLabel: UITextView!
    @IBOutlet weak var loadingGifImageView: UIImageView!
    
    var currentChallenges: [Challenge]?
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x57C3BB)
        loadingGifImageView.hidden = false
        tabBarController?.tabBar.barTintColor = UIColor(hex: 0x57C3BB)
        myChallengesTableView.delegate = self
        myChallengesTableView.dataSource = self
        loadingGifImageView.setGifImage(UIImage(gifName: "loadinggif"), manager: gifManager, loopCount: -1)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        myChallengesTableView.insertSubview(refreshControl, atIndex: 0)
        myChallengesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        feedViewController.videoController1.stopVideo()
        feedViewController.videoController2.stopVideo()
        
        currentChallenges = []
        updateChallengeInfo()
        makeChallengePromptTextLabel.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        self.tabBarController?.tabBar.hidden = false
        makeChallengePromptTextLabel.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        makeChallengePromptTextLabel.removeObserver(self, forKeyPath: "contentSize")
    }
    
    /// Force the text in a UITextView to always center itself.
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.whiteColor()
            loadingGifImageView.hidden = true
        } else {
            cell.backgroundColor = UIColor(white: 0x57C3BB, alpha: 0.3)
        }
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
            loadingGifImageView.hidden = true
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
