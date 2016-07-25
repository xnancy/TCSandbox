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
            
           
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
                
                if self.workoutCount > 1 {
                
                    self.selectedMoveLabel1.hidden = true
                    self.gifSelectedImageView1.hidden = true
                    self.deleteButton1.hidden = true
                    self.badgeImage1.hidden = true
                    self.badgeLabel1.hidden = true
                    self.gifsToShow.removeAtIndex(0)
                    self.movesCount - 1
                    self.workoutCount - 1
                    
                    
                }
            })
            
           
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
        
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
        
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func didHoldImage2(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
               
                
                
                
                if self.workoutCount == 1 && self.tagsCount == 1 {
                
                    self.selectedMoveLabel2.hidden = true
                    self.gifSelectedImageView2.hidden = true
                    self.deleteButton2.hidden = true
                    self.badgeImage2.hidden = true
                    self.badgeLabel2.hidden = true
                    self.tagsToShow.removeAtIndex(0)
                    self.movesCount - 1
                    self.tagsCount - 1
                    
                
                }
                
                if self.workoutCount == 2 {
                    
                    
                    self.selectedMoveLabel2.hidden = true
                    self.gifSelectedImageView2.hidden = true
                    self.deleteButton2.hidden = true
                    self.badgeImage2.hidden = true
                    self.badgeLabel2.hidden = true
                    self.gifsToShow.removeAtIndex(1)
                    
                    self.movesCount - 1
                    self.workoutCount - 1
                    
                }
                
            })
            
          
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
         
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
         
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func didHoldImage3(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
           
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
              
                if self.workoutCount == 3 {
                
                    self.selectedMoveLabel3.hidden = true
                    self.gifSelectedImageView4.hidden = true
                    self.deleteButton3.hidden = true
                    self.badgeImage3.hidden = true
                    self.badgeLabel3.hidden = true
                    self.gifsToShow.removeAtIndex(2)
                    self.movesCount - 1
                    self.workoutCount - 1
                    
              
                }
                
                if self.workoutCount == 2 && self.tagsCount == 1 {
                    
                    
                    self.selectedMoveLabel3.hidden = true
                    self.gifSelectedImageView4.hidden = true
                    self.deleteButton3.hidden = true
                    self.badgeImage3.hidden = true
                    self.badgeLabel3.hidden = true
                    self.tagsToShow.removeAtIndex(0)
                    self.movesCount - 1
                    self.tagsCount - 1
                    
                    
                    
                }
                
                if self.workoutCount == 1 && self.tagsCount == 2 {
                    
                    
                    self.selectedMoveLabel3.hidden = true
                    self.gifSelectedImageView4.hidden = true
                    self.deleteButton3.hidden = true
                    self.badgeImage3.hidden = true
                    self.badgeLabel3.hidden = true
                    self.gifsToShow.removeAtIndex(1)
                    self.movesCount - 1
                    self.workoutCount - 1
                    
                    
                }
                
                if self.workoutCount == 1 && self.tagsCount == 3{
                    
                    self.selectedMoveLabel3.hidden = true
                    self.gifSelectedImageView4.hidden = true
                    self.deleteButton3.hidden = true
                    self.badgeImage3.hidden = true
                    self.badgeLabel3.hidden = true
                    self.gifsToShow.removeAtIndex(1)
                    self.movesCount - 1
                    self.workoutCount - 1
                    
                    
                }
                
                if self.workoutCount == 2 && self.tagsCount == 2 {
                    
                    
                    self.selectedMoveLabel3.hidden = true
                    self.gifSelectedImageView4.hidden = true
                    self.deleteButton3.hidden = true
                    self.badgeImage3.hidden = true
                    self.badgeLabel3.hidden = true
                    self.gifsToShow.removeAtIndex(1)
                    self.movesCount - 1
                    self.workoutCount - 1
                    
                    
                }
            })
            
          
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
            
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func didHoldImage4(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            

            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
             
                
                if self.workoutCount == 4 {
                    
                    self.selectedMoveLabel4.hidden = true
                    self.gifSelectedImageView3.hidden = true
                    self.deleteButton4.hidden = true
                    self.badgeImage4.hidden = true
                    self.badgeLabel4.hidden = true
                    self.gifsToShow.removeAtIndex(3)
                    self.movesCount - 1
                    self.workoutCount - 1
                    
                    
                } else if self.workoutCount == 3 && self.tagsCount == 1 {
                    
                    
                    self.selectedMoveLabel4.hidden = true
                    self.gifSelectedImageView3.hidden = true
                    self.deleteButton4.hidden = true
                    self.badgeImage4.hidden = true
                    self.badgeLabel4.hidden = true
                    self.tagsToShow.removeAtIndex(0)
                    self.movesCount - 1
                    self.tagsCount - 1

                } else if self.workoutCount == 2 && self.tagsCount == 2 {
                    
                    self.selectedMoveLabel4.hidden = true
                    self.gifSelectedImageView3.hidden = true
                    self.deleteButton4.hidden = true
                    self.badgeImage4.hidden = true
                    self.badgeLabel4.hidden = true
                    self.tagsToShow.removeAtIndex(1)
                    self.movesCount - 1
                    self.tagsCount - 1

                } else if self.workoutCount == 1 && self.tagsCount == 3 {
                    
                    self.selectedMoveLabel4.hidden = true
                    self.gifSelectedImageView3.hidden = true
                    self.deleteButton4.hidden = true
                    self.badgeImage4.hidden = true
                    self.badgeLabel4.hidden = true
                    self.tagsToShow.removeAtIndex(2)
                    self.movesCount - 1
                    self.tagsCount - 1

                }
                
                
            })
            
          
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            
           
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
          
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
