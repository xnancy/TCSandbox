//
//  Video.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/13/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import MobileCoreServices

class Video: NSObject
{
    static let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    
    class func recordVideo()
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            imagePicker.sourceType = .Camera
            imagePicker.mediaTypes = [kUTTypeMovie as String] //check this at runtime
            imagePicker.allowsEditing = false
            //imagePicker.delegate = the view controller we want here
            
            //presentViewController(imagePicker, animated: true, completion: {})
        }
    }
}
