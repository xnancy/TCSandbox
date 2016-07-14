//
//  recordVideoViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/14/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import MobileCoreServices

class recordVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var pickedVideo: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRecordVideo(sender: AnyObject) {
        imagePicker.sourceType = .Camera
        imagePicker.mediaTypes = [kUTTypeMovie as String] //check this at runtime
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: {})
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
    
    @IBAction func onUploadVideo(sender: AnyObject) {
        //upload video to our database and associate it with the correct challenge
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
