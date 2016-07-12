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
    
    /* ---------- DGRunkeeperSwitch ---------- */
    static func setRepetitionTypeSwitch(rSwitch: DGRunkeeperSwitch) {
        rSwitch.leftTitle = repetitionTypeOptions[0]
        rSwitch.rightTitle = repetitionTypeOptions[1]
        rSwitch.backgroundColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        rSwitch.selectedBackgroundColor = .whiteColor()
        rSwitch.titleColor = .whiteColor()
        rSwitch.selectedTitleColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        rSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        rSwitch.autoresizingMask = [.FlexibleWidth]
        rSwitch.addTarget(self, action: #selector(UIHomeElementMaker.repetitionTypeSwitchValueChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    /* ---------- SNAPPING STEPPER ---------- */
    static func setRepetitionCountStepper(sStepper: SnappingStepper) {
        // Configure the stepper like any other UIStepper. For example:
        
        sStepper.continuous   = true
        sStepper.autorepeat   = true
        sStepper.wraps        = true
        sStepper.minimumValue = 0
        sStepper.maximumValue = 250
        sStepper.stepValue    = 1
        
        sStepper.style                = .Box
        sStepper.thumbStyle           = .Tube
        sStepper.borderColor          = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        sStepper.borderWidth          = 0.5
        sStepper.hintStyle            = .Rounded
        
        sStepper.symbolFont           = UIFont(name: "TrebuchetMS-Bold", size: 20)
        sStepper.symbolFontColor      = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        sStepper.backgroundColor      = UIColor.whiteColor()
        sStepper.thumbWidthRatio      = 0.4
        sStepper.thumbText            = nil
        sStepper.thumbFont            = UIFont(name: "TrebuchetMS-Bold", size: 18)
        sStepper.thumbBackgroundColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        sStepper.thumbTextColor       = UIColor.whiteColor()
        
        sStepper.continuous   = true
        sStepper.autorepeat   = true
        sStepper.wraps        = false
        sStepper.minimumValue = 0
        sStepper.maximumValue = 1000
        sStepper.stepValue    = 1
        sStepper.addTarget(self, action: "repetitionCountStepperValueChanged:", forControlEvents: .ValueChanged)
        
        // If you don't want using the traditional `addTarget:action:` pattern you can use
        // the `valueChangedBlock`
        // snappingStepper.valueChangeBlock = { (value: Double) in
        //    println("value: \(value)")
        // }
    }
    
    static func repetitionCountStepperValueChanged(sender: AnyObject) {
        let cellIndexPath = workoutEditorTableView!.indexPathForCell(((sender as! SnappingStepper).superview?.superview!) as! UITableViewCell)

    }
    
    static func repetitionTypeSwitchValueChanged(sender: AnyObject) {
        let cellIndexPath = workoutEditorTableView!.indexPathForCell(((sender as! DGRunkeeperSwitch).superview!.superview!) as! UITableViewCell)

    }

}