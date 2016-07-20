//
//  WorkoutEditorViewController.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import MobileCoreServices
import SnappingStepper
import DGRunkeeperSwitch
import SwiftyGif
import FBSDKCoreKit
import FBSDKLoginKit



class WorkoutEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /* ---------- OUTLETS ---------- */
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var gifSelectedImageView1: UIImageView!
    @IBOutlet weak var gifSelectedImageView2: UIImageView!
    @IBOutlet weak var gifSelectedImageView3: UIImageView!
    @IBOutlet weak var gifSelectedImageView4: UIImageView!
    @IBOutlet weak var nameChallengeTextField: UITextField!
    @IBOutlet weak var selectedMoveLabel1: UILabel!
    @IBOutlet weak var selectedMoveLabel2: UILabel!
    @IBOutlet weak var selectedMoveLabel3: UILabel!
    @IBOutlet weak var selectedMoveLabel4: UILabel!
    @IBOutlet weak var countdownStepper: UIStepper!
    @IBOutlet weak var deadlineStepper: UIStepper!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var secMinLabel: UILabel!
    @IBOutlet weak var daysWeekLabel: UILabel!
    @IBOutlet weak var badgeImage1: UIImageView!
    @IBOutlet weak var badgeImage2: UIImageView!
    @IBOutlet weak var badgeImage3: UIImageView!
    @IBOutlet weak var badgeImage4: UIImageView!
    @IBOutlet weak var barImage1: UIImageView!
    @IBOutlet weak var barImage2: UIImageView!
    @IBOutlet weak var barImage3: UIImageView!
    @IBOutlet weak var barImage4: UIImageView!
    @IBOutlet weak var badgeLabel1: UILabel!
    @IBOutlet weak var badgeLabel2: UILabel!
    @IBOutlet weak var badgeLabel3: UILabel!
    @IBOutlet weak var badgeLabel4: UILabel!
    @IBOutlet weak var barLabel1: UILabel!
    @IBOutlet weak var barLabel2: UILabel!
    @IBOutlet weak var barLabel3: UILabel!
    @IBOutlet weak var barLabel4: UILabel!
    
    
    @IBOutlet weak var recordButton: UIButton!
  
    /* ---------- VARIABLES ---------- */
    var gifManager = SwiftyGifManager(memoryLimit: 500)
    var gifManager2 = SwiftyGifManager(memoryLimit: 500)
    var gifsToShow: [String] = []
    var tagsToShow: [String] = []
    var cTags: [String] = []
    var movesCount: Int!
    var workoutCount: Int!
    var tagsCount: Int!
    var date = NSDate()
    var challenge: Challenge?
    var fm: CGRect = UIScreen.mainScreen().bounds
    //var peekAndPopCount: Int!
    
    var pickedVideo: NSURL?
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.enabled = false
        self.nameChallengeTextField.delegate = self
        countdownLabel.text = "1:00"
        daysWeekLabel.text = "day"

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WorkoutEditorViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        deadlineStepper.autorepeat = true
        deadlineStepper.maximumValue = 7
        deadlineStepper.minimumValue = 1
        countdownStepper.autorepeat = true
        countdownStepper.maximumValue = 120
        countdownStepper.minimumValue = 15
        
        selectedMoveLabel1.text = Gifs.gifDictionary[(gifsToShow[0])]
        gifSelectedImageView1.setGifImage(UIImage(gifName: gifsToShow[0]), manager: gifManager, loopCount: 20)
        
        if movesCount == 1 {
            
                        
//            gifSelectedImageView2.hidden = true
//            gifSelectedImageView4.hidden = true
//            gifSelectedImageView3.hidden = true
            
        }
        
        

        if workoutCount > 1 {
        
        if workoutCount == 2 {
        selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])]
        gifSelectedImageView2.setGifImage(UIImage(gifName: gifsToShow[1]), manager: gifManager, loopCount: 30)
        }
        
        if workoutCount == 3 {
        selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])]
        gifSelectedImageView2.setGifImage(UIImage(gifName: gifsToShow[1]), manager: gifManager2, loopCount: 30)
        selectedMoveLabel3.text = Gifs.gifDictionary[(gifsToShow[2])]
        gifSelectedImageView4.setGifImage(UIImage(gifName: gifsToShow[2]), manager: gifManager2, loopCount: 30)
        }
        
        if workoutCount == 4 {
        selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])]
        gifSelectedImageView2.setGifImage(UIImage(gifName: gifsToShow[1]), manager: gifManager, loopCount: 30)
        selectedMoveLabel3.text = Gifs.gifDictionary[(gifsToShow[2])]
        gifSelectedImageView4.setGifImage(UIImage(gifName: gifsToShow[2]), manager: gifManager2, loopCount: 30)
        selectedMoveLabel4.text = Gifs.gifDictionary[(gifsToShow[3])]
        gifSelectedImageView3.setGifImage(UIImage(gifName: gifsToShow[3]), manager: gifManager2, loopCount: 30)
        }
            
            
    }
        
        
        
        if tagsCount > 0 {
        
        if workoutCount == 1 {
            selectedMoveLabel2.text = Tags.tagDictionary[tagsToShow[0]]
            gifSelectedImageView2.image = UIImage(named: tagsToShow[0])
            
            if tagsCount == 2 {
                selectedMoveLabel3.text = Tags.tagDictionary[tagsToShow[1]]
                gifSelectedImageView4.image = UIImage(named: tagsToShow[1])
            }
                
            else if tagsCount == 3{
                selectedMoveLabel3.text = Tags.tagDictionary[tagsToShow[1]]
                gifSelectedImageView4.image = UIImage(named: tagsToShow[1])
                selectedMoveLabel4.text = Tags.tagDictionary[tagsToShow[2]]
                gifSelectedImageView3.image = UIImage(named: tagsToShow[2])
            }
            
            
        }
        else if workoutCount == 2 {
            selectedMoveLabel3.text = Tags.tagDictionary[tagsToShow[0]]
            gifSelectedImageView4.image = UIImage(named: tagsToShow[0])
            
            if tagsCount == 2{
                selectedMoveLabel4.text = Tags.tagDictionary[tagsToShow[1]]
                gifSelectedImageView3.image = UIImage(named: tagsToShow[1])
            }
    
        }
        else if workoutCount == 3 {
            selectedMoveLabel4.text = Tags.tagDictionary[tagsToShow[0]]
            gifSelectedImageView3.image = UIImage(named: tagsToShow[0])
            }
           
        }
        
        challenge = Challenge()
            
    }
    


    
    func convertToNSDate() -> NSDate{
        let today = NSDate()
        let futureDate = NSCalendar.currentCalendar()
            .dateByAddingUnit(
                .Day,
                value: Int(deadlineLabel.text!)!,
                toDate: today,
                options: []
        )
        
        return futureDate!
    }

    @IBAction func didPressRecord(sender: AnyObject) {
        imagePicker.sourceType = .Camera
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.videoMaximumDuration = Double(countdownStepper.value)
        
        presentViewController(imagePicker, animated: true, completion: {})
    }
   
   
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
 
    func dismissKeyboard() {
        
        view.endEditing(true)
    
    }

    
    func textFieldShouldReturn(nameChallengeTextField: UITextField) -> Bool {
        nameChallengeTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func didLogout(sender: AnyObject) {
        
        FBClient.logout()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
        
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func deadlineValueChanged(sender: AnyObject) {
        
        if deadlineStepper.value == 1{
            deadlineLabel.text = String(Int(deadlineStepper.value))
            daysWeekLabel.text = "day"
        }else if deadlineStepper.value < 7{
            deadlineLabel.text = String(Int(deadlineStepper.value))
            daysWeekLabel.text = "days"
        }else if deadlineStepper.value == 7{
            deadlineLabel.text = "1"
            daysWeekLabel.text = "week"
        }
    }
    
    @IBAction func editingDidEnd(sender: AnyObject) {

        let challengeName = nameChallengeTextField.text        
        if challengeName != ""
        {
            recordButton.enabled = true
        }
        
        challenge?.name = challengeName

    }
    @IBAction func countdownValueChanged(sender: AnyObject) {
        
        if countdownStepper.value < 60 {
            countdownLabel.text = String(Int(countdownStepper.value))
            secMinLabel.text = "s"
        }else{
            secMinLabel.text = ""
        }
        
        if countdownStepper.value == 60{
            countdownLabel.text = "1:00"
        }
        if countdownStepper.value == 75{
            countdownLabel.text = "1:15"
        }
        if countdownStepper.value == 90{
            countdownLabel.text = "1:30"
        }
        if countdownStepper.value == 105{
            countdownLabel.text = "1:45"
        }
        if countdownStepper.value == 120{
            countdownLabel.text = "2:00"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        challenge?.deadline = convertToNSDate()
        challenge?.timeLimit = Int(countdownStepper.value)

        challenge?.gifNames = gifsToShow
        challenge?.tagNames = tagsToShow
        challenge?.cTagNames = cTags
        let vc = segue.destinationViewController as! SendChallengeViewController
        vc.challenge = challenge
        vc.pickedVideo = pickedVideo

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("video recorded")
        
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
            self.pickedVideo = pickedVideo
            print("damn")
            print(pickedVideo)
        }
        
        imagePicker.dismissViewControllerAnimated(true) {
            self.performSegueWithIdentifier("uploadSegue", sender: self)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
