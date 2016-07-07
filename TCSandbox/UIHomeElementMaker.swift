//
//  UIHomeElementMaker.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/7/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation
import UIKit
import SnappingStepper
import DGRunkeeperSwitch
import SwiftyGif

class UIHomeElementMaker: NSObject {
    /* ---------- VARIABLES ---------- */
    static var repetitionTypeOptions = ["secs", "reps"]
    static var workoutEditorTableView: UITableView?
    static var currentWorkout: Workout?
    
    
    /* ---------- DGRunkeeperSwitch ---------- */
    static func makeRepetitionTypeSwitch() -> DGRunkeeperSwitch {
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
    static func makeRepetitionCountStepper() -> SnappingStepper {
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
    
    static func repetitionCountStepperValueChanged(sender: AnyObject) {
        let cellIndexPath = workoutEditorTableView!.indexPathForCell(((sender as! SnappingStepper).superview!) as! UITableViewCell)
        currentWorkout?.movesList![(cellIndexPath?.row)!].quantity = Int((sender as! SnappingStepper).value)
        ((sender as! SnappingStepper).superview! as! WorkoutEditorTableViewCell).repetitionQuantityLabel.text = String(currentWorkout?.movesList![(cellIndexPath?.row)!].quantity)
    }
    
    static func repetitionTypeSwitchValueChanged(sender: AnyObject) {
        let cellIndexPath = workoutEditorTableView!.indexPathForCell(((sender as! DGRunkeeperSwitch).superview!) as! UITableViewCell)
        currentWorkout?.movesList![(cellIndexPath?.row)!].repetitionType = repetitionTypeOptions[(sender as! DGRunkeeperSwitch).selectedIndex]
    }

}