import UIKit
import AVKit
import MediaPlayer
import MobileCoreServices
import SnappingStepper
import DGRunkeeperSwitch
import SwiftyGif
import FBSDKCoreKit
import FBSDKLoginKit
import PopupDialog

protocol WorkoutEditorDelegate{
    func didPressRecord(sender: AnyObject)
}

class WorkoutEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WorkoutEditorDelegate, UIPopoverPresentationControllerDelegate {
    
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
    @IBOutlet weak var badgeLabel1: UILabel!
    @IBOutlet weak var badgeLabel2: UILabel!
    @IBOutlet weak var badgeLabel3: UILabel!
    @IBOutlet weak var badgeLabel4: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var blurVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var deleteButton1: UIButton!
    @IBOutlet weak var deleteButton2: UIButton!
    @IBOutlet weak var deleteButton3: UIButton!
    @IBOutlet weak var deleteButton4: UIButton!
    @IBOutlet weak var countdowimageview: UIImageView!
    @IBOutlet weak var secondaryBackgroundImageView: UIImageView!
    @IBOutlet weak var referenceLabel: UILabel!

    @IBOutlet weak var titleNeededButton: UIButton!
    
    /* ---------- VARIABLES ---------- */
    
    
    
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    var gifManager2 = SwiftyGifManager(memoryLimit: 50)
    var gifsToShow: [String] = []
    var tagsToShow: [String] = []
    var cTags: [String] = []
    var movesCount: Int = 0
    var workoutCount: Int = 0
    var tagsCount: Int = 0
    var date = NSDate()
    var challenge: Challenge?
    var fm: CGRect = UIScreen.mainScreen().bounds
    
    var pickedVideo: NSURL?
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordButton.enabled = true
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
        gifSelectedImageView1.setGifImage(UIImage(gifName: gifsToShow[0]), manager: gifManager, loopCount: 100)
        
        print(cTags.count)
        
        if cTags.count >= 1 {
            
            "called"
            if cTags[0] == "5X" {
                
                badgeImage1.hidden = false
                badgeLabel1.hidden = false
                badgeLabel1.text = "5X"
                
            }else if cTags[0] == "10X" {
                
                badgeImage1.hidden = false
                badgeLabel1.hidden = false
                badgeLabel1.text = "10X"
                
            } else if cTags[0] == "20X" {
                
                badgeImage1.hidden = false
                badgeLabel1.hidden = false
                badgeLabel1.text = "20X"
                
            } else if cTags[0] == "MTM" {
                
                badgeImage1.hidden = false
                badgeLabel1.hidden = false
                badgeLabel1.text = "MTM"
            }
            
        }
        
        if cTags.count >= 2 {
            
            if cTags[1] == "5X" {
                
                badgeImage2.hidden = false
                badgeLabel2.hidden = false
                badgeLabel2.text = "5X"
                
            }else if cTags[1] == "10X" {
                
                badgeImage2.hidden = false
                badgeLabel2.hidden = false
                badgeLabel2.text = "10X"
                
            } else if cTags[1] == "20X" {
                
                badgeImage2.hidden = false
                badgeLabel2.hidden = false
                badgeLabel2.text = "20X"
                
            } else if cTags[1] == "MTM" {
                
                badgeImage1.hidden = false
                badgeLabel1.hidden = false
                badgeLabel1.text = "MTM"
            }
            
            
        }
        
        if cTags.count >= 3 {
            
            
            if cTags[2] == "5X" {
                
                badgeImage3.hidden = false
                badgeLabel3.hidden = false
                badgeLabel3.text = "5X"
                
            }else if cTags[2] == "10X" {
                
                badgeImage4.hidden = false
                badgeLabel3.hidden = false
                badgeLabel3.text = "10X"
                
            } else if cTags[2] == "20X" {
                
                badgeImage3.hidden = false
                badgeLabel3.hidden = false
                badgeLabel3.text = "20X"
                
            } else if cTags[2] == "MTM" {
                
                badgeImage3.hidden = false
                badgeLabel3.hidden = false
                badgeLabel3.text = "MTM"
            }
            
        }
        
        if cTags.count == 4 {
            
            
            if cTags[3] == "5X" {
                
                badgeImage4.hidden = false
                badgeLabel4.hidden = false
                badgeLabel1.text = "5X"
                
            }else if cTags[3] == "10X" {
                
                badgeImage3.hidden = false
                badgeLabel4.hidden = false
                badgeLabel4.text = "10X"
                
            } else if cTags[3] == "20X" {
                
                badgeImage4.hidden = false
                badgeLabel4.hidden = false
                badgeLabel1.text = "20X"
                
            } else if cTags[3] == "MTM" {
                
                badgeImage4.hidden = false
                badgeLabel4.hidden = false
                badgeLabel4.text = "MTM"
            }
            
            
        }
        
        
        if movesCount == 1 {
            
            
            gifSelectedImageView2.hidden = true
            deleteButton2.hidden = true
            selectedMoveLabel2.hidden = true
            deleteButton3.hidden = true
            gifSelectedImageView4.hidden = true
            selectedMoveLabel3.hidden = true
            deleteButton4.hidden = true
            gifSelectedImageView3.hidden = true
            selectedMoveLabel4.hidden = true
            
        }
            
        else if movesCount == 2 {
            
            gifSelectedImageView4.hidden = true
            selectedMoveLabel3.hidden = true
            deleteButton3.hidden = true
            gifSelectedImageView3.hidden = true
            selectedMoveLabel4.hidden = true
            deleteButton4.hidden = true
            
        }
            
        else if movesCount == 3 {
            
            gifSelectedImageView3.hidden = true
            deleteButton4.hidden = true
            selectedMoveLabel4.hidden = true
            
        }
        
        
        
        if workoutCount > 1 {
            
            if workoutCount == 2 {
                selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])]
                gifSelectedImageView2.setGifImage(UIImage(gifName: gifsToShow[1]), manager: gifManager, loopCount: 100)
            }
            
            if workoutCount == 3 {
                selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])]
                gifSelectedImageView2.setGifImage(UIImage(gifName: gifsToShow[1]), manager: gifManager, loopCount: 100)
                selectedMoveLabel3.text = Gifs.gifDictionary[(gifsToShow[2])]
                gifSelectedImageView4.setGifImage(UIImage(gifName: gifsToShow[2]), manager: gifManager, loopCount: 100)
            }
            
            if workoutCount == 4 {
                
                selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])]
                gifSelectedImageView2.setGifImage(UIImage(gifName: gifsToShow[1]), manager: gifManager, loopCount: 100)
                selectedMoveLabel3.text = Gifs.gifDictionary[(gifsToShow[2])]
                gifSelectedImageView4.setGifImage(UIImage(gifName: gifsToShow[2]), manager: gifManager, loopCount: 100)
                selectedMoveLabel4.text = Gifs.gifDictionary[(gifsToShow[3])]
                gifSelectedImageView3.setGifImage(UIImage(gifName: gifsToShow[3]), manager: gifManager, loopCount: 100)
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
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func didPressRecord(sender: AnyObject) {
        self.secondaryBackgroundImageView.hidden = false
        //countdowimageview.hidden = false
        self.countdowimageview.hidden = false
        
        self.countdowimageview.setGifImage(UIImage(gifName: "giffy"), manager: self.gifManager, loopCount: 1)
        view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            // animate it to the identity transform (100% scale)
            self.view.transform = CGAffineTransformIdentity;
        }) { (finished) -> Void in
            // if you want to do something once the animation finishes, put it here
            
            
            UIDevice.currentDevice().orientation
            //shouldAutorotate()
            //supportedInterfaceOrientations()
            
            
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 6 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                //put your code which should be executed with a delay here
                let delayInSeconds: Int64 = 1
                
                let popTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * Int64(NSEC_PER_SEC))
                dispatch_after(popTime, dispatch_get_main_queue(), {() -> Void in
                    
                    self.imagePicker.startVideoCapture()
                    self.countdowimageview.hidden = true
                    self.imagePicker.performSelector(#selector(self.imagePicker.stopVideoCapture), withObject: nil, afterDelay: 15)
                    
                    
                })
                
                self.presentViewController(self.imagePicker, animated: true, completion: {})
                self.imagePicker.allowsEditing = false
                self.imagePicker.delegate = self
                self.imagePicker.videoMaximumDuration = Double(120)
                self.imagePicker.sourceType = .Camera
                self.imagePicker.mediaTypes = [kUTTypeMovie as String]
                
            }

        }
        
//        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve , animations: {
//            
//            //self.countdowimageview.frame.origin.y = -1000
//            self.view.layoutIfNeeded()
//            }, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        countdowimageview.hidden = true
        secondaryBackgroundImageView.hidden = true
        
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
    
    
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func editingDidEnd(sender: AnyObject) {
        
        let challengeName = nameChallengeTextField.text
        if challengeName != ""
        {
            titleNeededButton.hidden = true
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
        
        secondaryBackgroundImageView.hidden = true
    }
    
    

    
    @IBAction func didpressConfirm(sender: AnyObject) {
        //blurVisualEffectView.hidden = false
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let confirmationVC: ConfirmationPopOverViewController = (storyboard.instantiateViewControllerWithIdentifier("ConfirmationVC") as? ConfirmationPopOverViewController)!
        
        confirmationVC.modalPresentationStyle = .Popover
        confirmationVC.preferredContentSize = CGSizeMake(270, 50)
        confirmationVC.gifsNames = gifsToShow
        confirmationVC.tagNames = tagsToShow
        confirmationVC.gifCount = workoutCount
        confirmationVC.tagCount = tagsCount
        print(tagsCount)
        print(workoutCount)
        let popOverVC = confirmationVC.popoverPresentationController
        popOverVC?.sourceView = referenceLabel
        popOverVC?.permittedArrowDirections = .Up
        popOverVC?.delegate = self
       
        
        
        presentViewController(
            confirmationVC,
            animated: true,
            completion: nil)
       
        
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        //blurVisualEffectView.hidden = true
        //confirmButton.hidden = false
        
    }
    
    @IBAction func didPressPopUp(sender: UIButton) {
        //blurVisualEffectView.hidden = false
        showCustomDialog()
        
    }
    
    func showCustomDialog() {
        
        
        // Create a custom view controller
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        ratingVC.delegate = self
        ratingVC.timeLimit = Int(countdownStepper.value)
        ratingVC.gifnames = gifsToShow
        ratingVC.tagnames = tagsToShow
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, transitionStyle: .BounceDown, buttonAlignment: .Horizontal, gestureDismissal: true)
        
        
        // Create second button
        let buttonTwo = DefaultButton(title: "RECORD") {
            
            self.didPressRecord(DefaultButton)
            //self.blurVisualEffectView.hidden = true
        }
    
        // Add buttons to dialog
        popup.addButtons([buttonTwo])
        
        // Present dialog
        presentViewController(popup, animated: true, completion: nil)
    }
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("video recorded")
        
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
            self.pickedVideo = pickedVideo
            
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
