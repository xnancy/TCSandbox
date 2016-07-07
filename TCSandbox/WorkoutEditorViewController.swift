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


class WorkoutEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var workoutEditorTableView: UITableView!
    
    /* ---------- VARIABLES ---------- */
    var gifmanager = SwiftyGifManager(memoryLimit: 20)
    var currentWorkout: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentWorkout = Workout()
        
        let newMove = Move()
        currentWorkout?.movesList?.append(newMove)
        
        workoutEditorTableView.delegate = self
        workoutEditorTableView.dataSource = self
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ---------- TABLE VIEW DATA SOURCE ---------- */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = workoutEditorTableView.dequeueReusableCellWithIdentifier("workoutEditorTableCell") as! WorkoutEditorTableViewCell
        
        // Add gif to imageview
        //let gif = UIImage(gifName:git  "Gifs/steps.gif")
        //cell.gifImageView.setGifImage(gif, manager: gifmanager, loopCount: 20)
        // Ad stepper and switch to imageview
        UIHomeElementMaker.workoutEditorTableView = workoutEditorTableView
        UIHomeElementMaker.currentWorkout = currentWorkout
        cell.addSubview(UIHomeElementMaker.makeRepetitionTypeSwitch())
        cell.addSubview(UIHomeElementMaker.makeRepetitionCountStepper())
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentWorkout?.movesList?.count)!
    }    
}
