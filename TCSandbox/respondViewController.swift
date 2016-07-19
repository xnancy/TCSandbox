//
//  respondViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/18/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import MobileCoreServices

class respondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var pickedVideo: NSURL?
    var challenge: Challenge?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .Camera
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: {})


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("video recorded")
        
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
            self.pickedVideo = pickedVideo
            print(pickedVideo)
        }
        
        imagePicker.dismissViewControllerAnimated(true) {
            
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
