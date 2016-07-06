//
//  WorkoutEditorViewController.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import DGRunkeeperSwitch
import SnappingStepper

class WorkoutEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* ---------- OUTLETS ---------- */
    @IBOutlet weak var workoutEditorTableView: UITableView!
    
    /* ---------- VARIABLES ---------- */
    var repetitionTypeOptions = ["secs", "reps"]
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
        let cell = workoutEditorTableView.dequeueReusableCellWithIdentifier("workoutEditorTableCell")
        cell?.addSubview(makeRepetitionTypeSwitch())
        cell?.addSubview(makeRepetitionCountStepper())
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentWorkout?.movesList?.count)!
    }
    
    /* --------- RUNKEEPER SWITCH ---------- */
    func makeRepetitionTypeSwitch() -> DGRunkeeperSwitch {
        let runkeeperSwitch = DGRunkeeperSwitch(leftTitle: repetitionTypeOptions[0], rightTitle: repetitionTypeOptions[1])
        runkeeperSwitch.backgroundColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        runkeeperSwitch.selectedBackgroundColor = .whiteColor()
        runkeeperSwitch.titleColor = .whiteColor()
        runkeeperSwitch.selectedTitleColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitch.frame = CGRect(x: 200.0, y: 20.0, width: 100, height: 30.0)
        runkeeperSwitch.autoresizingMask = [.FlexibleWidth]
        runkeeperSwitch.addTarget(self, action: "repetitionTypeSwitchValueChanged:", forControlEvents: .ValueChanged)
        return runkeeperSwitch
    }
    
    /* ---------- SNAPPING STEPPER ---------- */
    func makeRepetitionCountStepper() -> SnappingStepper {
        let stepper = SnappingStepper(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        // Configure the stepper like any other UIStepper. For example:
        //
        
        stepper.continuous   = true
        stepper.autorepeat   = true
        stepper.wraps        = true
        stepper.minimumValue = 0
        stepper.maximumValue = 250
        stepper.stepValue    = 1
        
        stepper.style                = .Rounded
        stepper.thumbStyle           = .Rounded
        stepper.borderColor          = UIColor(hex: 0xFFC107)
        stepper.borderWidth          = 0.5
        stepper.hintStyle            = .Thumb
        
        stepper.symbolFont           = UIFont(name: "TrebuchetMS-Bold", size: 20)
        stepper.symbolFontColor      = .blackColor()
        stepper.backgroundColor      = UIColor(hex: 0xc0392b)
        stepper.thumbWidthRatio      = 0.4
        stepper.thumbText            = nil
        stepper.thumbFont            = UIFont(name: "TrebuchetMS-Bold", size: 18)
        stepper.thumbBackgroundColor = UIColor(hex: 0xe74c3c)
        stepper.thumbTextColor       = .blackColor()
        
        stepper.continuous   = true
        stepper.autorepeat   = true
        stepper.wraps        = false
        stepper.minimumValue = 0
        stepper.maximumValue = 1000
        stepper.stepValue    = 1
        stepper.addTarget(self, action: "repetitionCountStepperValueChanged:", forControlEvents: .ValueChanged)
        
        // If you don't want using the traditional `addTarget:action:` pattern you can use
        // the `valueChangedBlock`
        // snappingStepper.valueChangeBlock = { (value: Double) in
        //    println("value: \(value)")
        // }
        
        return stepper
    }
    
    func repetitionCountStepperValueChanged(sender: AnyObject) {
        let cellIndexPath = workoutEditorTableView.indexPathForCell(((sender as! SnappingStepper).superview!) as! UITableViewCell)
        currentWorkout?.movesList![(cellIndexPath?.row)!].quantity = Int((sender as! SnappingStepper).value)
        ((sender as! SnappingStepper).superview! as! WorkoutEditorTableViewCell).repetitionQuantityLabel.text = String(currentWorkout?.movesList![(cellIndexPath?.row)!].quantity)
    }
    
    func repetitionTypeSwitchValueChanged(sender: AnyObject) {
        let cellIndexPath = workoutEditorTableView.indexPathForCell(((sender as! DGRunkeeperSwitch).superview!) as! UITableViewCell)
        currentWorkout?.movesList![(cellIndexPath?.row)!].repetitionType = repetitionTypeOptions[(sender as! DGRunkeeperSwitch).selectedIndex]
    }
}
