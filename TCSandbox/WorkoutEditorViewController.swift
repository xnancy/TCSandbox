//
//  WorkoutEditorViewController.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SnappingStepper
import DGRunkeeperSwitch
import SwiftyGif
import FBSDKCoreKit
import FBSDKLoginKit



class WorkoutEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var workoutEditorTableView: UITableView!
    
    
    /* ---------- VARIABLES ---------- */
    var gifmanager = SwiftyGifManager(memoryLimit: 20)
    var navigationBarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        User.updateCurrentUser()
        
        // Create editable navigation bar title
        navigationBarTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        navigationBarTextField.placeholder = "Name Your Workout..."
        navigationBarTextField.font = UIFont.systemFontOfSize(19)
        navigationBarTextField.textColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        navigationBarTextField.textAlignment = .Center
        navigationBarTextField.addTarget(self, action: "navigationBarTextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)

        self.navigationItem.titleView = navigationBarTextField

        // TESTING: Add temp move to workout

        
        // Set table view delegate/data source
        workoutEditorTableView.delegate = self
        workoutEditorTableView.dataSource = self
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ---------- NAVIGATION BAR TEXT FIELD ---------- */
    func navigationBarTextFieldDidChange() {
    }
    
    /* ---------- TABLE VIEW DATA SOURCE ---------- */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = workoutEditorTableView.dequeueReusableCellWithIdentifier("workoutEditorTableCell") as! WorkoutEditorTableViewCell
        
        // Add gif to cell
        let gif = UIImage(gifName: "pushup")
        cell.gifImageView.setGifImage(gif, manager: gifmanager, loopCount: 20)
        
        // Add stepper and switch to cell using UIHomeElementMaker
        UIHomeElementMaker.workoutEditorTableView = workoutEditorTableView
        UIHomeElementMaker.setRepetitionTypeSwitch(cell.repetitionTypeSwitch)
        UIHomeElementMaker.setRepetitionCountStepper(cell.repetitionQuantityStepper)
        
        return cell
    }
    

    @IBAction func didLogout(sender: AnyObject) {
        FBClient.logout()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
        
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 //CHANGE THIS LATER TO THE NUMBER OF MOVES IN THE CURRENT WORKOUT
    }
    
}
