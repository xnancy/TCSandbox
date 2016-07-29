//
//  SettingsViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/22/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        logOutButton.layer.cornerRadius = 5
        logOutButton.layer.borderWidth = 1
        logOutButton.layer.borderColor = UIColor.blackColor().CGColor
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapLogout(sender: AnyObject) {
        
        FBClient.logout()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let src: UIViewController = self
        let dst: UIViewController = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
        UIView.beginAnimations("LeftFlip", context: nil)
        UIView.setAnimationDuration(0.8)
        UIView.setAnimationCurve(.EaseInOut)
        UIView.setAnimationTransition(.FlipFromLeft, forView: src.view.superview!, cache: true)
        UIView.commitAnimations()
        src.presentViewController(dst, animated: false, completion: { _ in })

        
    }
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
