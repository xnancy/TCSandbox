//
//  ChallengeDetailViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/18/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import AVKit
import MediaPlayer
import MobileCoreServices
import SwiftyGif
import PopupDialog
import SwiftGifOrigin

var gifManager = SwiftyGifManager(memoryLimit: 1000)
private var playbackLikelyToKeepUpContext = 0

class ChallengeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var challenge: Challenge?
    var didRespond: Bool?
    var pickedVideo: NSURL?
    var user: User?
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var videoController: CustomVideoPlayerViewController?
    
    @IBOutlet weak var gifImageView: UIImageView! // = UIImageView(gifImage: UIImage(gifName: "hipairplane"), manager: gifManager)
    @IBOutlet weak var tagImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    @IBOutlet weak var countdownview: UIView!
    
    @IBOutlet weak var countdownImageView: UIImageView!
    @IBOutlet weak var secondaryBackgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.masksToBounds = true

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        var niceDateFormatter1: NSDateFormatter? = NSDateFormatter()
        var niceDateFormatter2: NSDateFormatter? = NSDateFormatter()
        niceDateFormatter1!.dateFormat = "hh:mm"
        niceDateFormatter2!.dateFormat = "EEEE"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)

        //create self.challenge from challengeID
        
        self.tabBarController?.tabBar.hidden = true
        
        challengeTitleLabel.text = challenge?.name
        deadlineLabel.text = niceDateFormatter1!.stringFromDate(challenge!.deadline!) + " " + niceDateFormatter2!.stringFromDate(challenge!.deadline!)
        var sender = User()
        FBClient.retrieveUserFromID((challenge?.senderID)!) { (user) in
            sender = user
            let profileURL = NSURL(string: sender.profileImageURLString!)
            self.profileImageView.setImageWithURL(profileURL!)
            
            FBClient.streamVideo((self.challenge?.challengeID)!, userID: (self.challenge?.senderID)!, completion: {(metadata: FIRStorageMetadata) in
                
                let downloadUrl = metadata.downloadURL()
                
                if downloadUrl != nil{
                    self.videoController = CustomVideoPlayerViewController()
                    self.videoController!.videoURL = downloadUrl
                    self.videoController?.setVideo(AVPlayerItem(URL: downloadUrl!))
                    self.addChildViewController(self.videoController!)
                    self.videoController!.view.frame = self.videoView.frame
                    self.view.addSubview(self.videoController!.view)
                    self.videoController!.didMoveToParentViewController(self)
                }
            
            })
        }

        // Do any additional setup after loading the view.

        
        if ((challenge?.completedBy?.contains(FBSDKAccessToken.currentAccessToken().userID)) != false)
        {
            didRespond = true
        }
        
        else
        {
            didRespond = false
        }
        
        self.detailsTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        
        gifImageView.image = UIImage.gifWithName((challenge?.gifNames![0])!)
        self.navigationItem.title = challenge!.name
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        videoController?.view.hidden = false
        videoView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if challenge?.gifNames!.count > indexPath.row
        {
            tagImageView.alpha = 0.0
            gifImageView.image = UIImage.gifWithName((challenge?.gifNames![indexPath.row])!)!
        }
        else {
            tagImageView.alpha = 1.0
            tagImageView.image = UIImage(named: (challenge?.tagNames![indexPath.row-(challenge?.gifNames?.count)!])!)
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (challenge?.tagNames![0] != "placeholder") //gif will always have something, so not necessary to check this for gifs as well
        {
            return (challenge?.gifNames?.count)! + (challenge?.tagNames?.count)!
        }
                
        return (challenge?.gifNames?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = detailsTableView.dequeueReusableCellWithIdentifier("detailCell") as! detailsTableViewCell
        
        if challenge?.gifNames!.count > indexPath.row
        {
            cell.exerciseLabel.text = Gifs.gifDictionary[(challenge?.gifNames![indexPath.row])!]
            if (challenge?.cTagNames![indexPath.row] != "placeholder") {
                cell.cTagTextLable.hidden = false
                cell.cTagImageView.hidden = false
                cell.cTagTextLable.text = challenge?.cTagNames![indexPath.row]
            }
        }
        
        else if challenge?.tagNames?.count > indexPath.row - (challenge?.gifNames?.count)!
        {
            cell.exerciseLabel.text = Tags.tagDictionary[(challenge?.tagNames![indexPath.row-(challenge?.gifNames?.count)!])!]
        }
        return cell
    }
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBAction func didPressRespond(sender: AnyObject) {
        if didRespond!
        {
            
        }
            
            else
        {
            self.navigationController?.navigationBarHidden = true
            self.countdownImageView.hidden = false
            videoView.hidden = true
            videoController?.view.hidden = true
            self.countdownImageView.setGifImage(UIImage(gifName: "giffy"), manager: gifManager, loopCount: 1)
            view.transform = CGAffineTransformMakeScale(0.01, 0.01);
            
            UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                // animate it to the identity transform (100% scale)
                self.view.transform = CGAffineTransformIdentity;
            }) { (finished) -> Void in
                
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 6 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    //put your code which should be executed with a delay here
                    let delayInSeconds: Int64 = 1
                    
                    let popTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * Int64(NSEC_PER_SEC))
                    dispatch_after(popTime, dispatch_get_main_queue(), {() -> Void in
                        self.imagePicker.startVideoCapture()
                        self.countdownImageView.hidden = true
                        self.imagePicker.performSelector(#selector(self.imagePicker.stopVideoCapture), withObject: nil, afterDelay: 15)
                        
                        
                    })
            
            self.imagePicker.sourceType = .Camera
            self.imagePicker.showsCameraControls = true
            self.imagePicker.mediaTypes = [kUTTypeMovie as String]
            self.imagePicker.allowsEditing = true
            self.imagePicker.delegate = self
            self.imagePicker.videoMaximumDuration = Double(120)
            
            
            self.presentViewController(self.imagePicker, animated: true, completion: {})
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.navigationController?.navigationBarHidden = false
        dismissViewControllerAnimated(true, completion: nil)
        countdownImageView.hidden = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //countdownview.hidden = true
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
            self.pickedVideo = pickedVideo
    
        }
        
        imagePicker.dismissViewControllerAnimated(true) {
                
            FBClient.uploadVideo(self.pickedVideo!, challenge: self.challenge!)
                
            //let homeViewController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("initialViewController")
            
            //popupImage()
            self.showCustomDialog()
            
            self.delay(2){
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }
    
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    func showCustomDialog() {
        
        
        // Create a custom view controller
        let sentVC = ChallengeSentViewController(nibName: "ChallengeSentViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: sentVC, transitionStyle: .BounceDown, buttonAlignment: .Horizontal, gestureDismissal: false)
        
        // Create second button
        
        
        // Present dialog
        self.presentViewController(popup, animated: true, completion: nil)
        
        delay(2){self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destinationViewController as! respondViewController
        
        vc.challenge = challenge
        vc.pickedVideo = pickedVideo
    }
 

}
