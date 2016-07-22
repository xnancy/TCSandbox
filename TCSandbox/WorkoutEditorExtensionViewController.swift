//
//  WorkoutEditorExtensionViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/22/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

extension WorkoutEditorViewController {

    
    @IBAction func didHoldImage1(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
                
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func didHoldImage2(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
                
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func didHoldImage3(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
                
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func didHoldImage4(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
                
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
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
