//
//  recordVideoViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/14/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class recordVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var pickedVideo: NSURL?
    var challenge: Challenge?
    
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
        if let pickedVideo = pickedVideo
        {
            let userVideoRef = FBClient.storageRef.child(FBSDKAccessToken.currentAccessToken().userID)
            let videoRef = userVideoRef.child((challenge?.challengeID)!)
            
            let uploadTask = videoRef.putFile(pickedVideo, metadata: nil) { metadata, error in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata!.downloadURL
                    //stream the video from the download URL on the screen?
                }
            }
            
            performSegueWithIdentifier("sendChallenge", sender: self)
        }
        
        
    }
    
    @IBAction func backButtonAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! SendChallengeViewController
        
        vc.challenge = challenge
    }
 

}
