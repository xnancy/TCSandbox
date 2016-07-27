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

var gifManager = SwiftyGifManager(memoryLimit: 1000)

class ChallengeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var challenge: Challenge?
    var didRespond: Bool?
    var pickedVideo: NSURL?

    var user: User?
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    @IBOutlet weak var gifImageView: UIImageView! // = UIImageView(gifImage: UIImage(gifName: "hipairplane"), manager: gifManager)
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var countdownImageView: UIImageView!
    @IBOutlet weak var secondaryBackgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            FBClient.downloadVideo((self.challenge?.challengeID)!, userID: (self.challenge?.senderID)!, completion: {(URL: NSURL) in
                
                let player = AVPlayer(URL: URL)
                let movie = AVPlayerViewController()
                movie.player = player
                movie.view.frame = self.videoView.bounds
                
                self.view.addSubview(movie.view)
                player.play()
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
        gifImageView.setGifImage(UIImage(gifName: (challenge?.gifNames![0])!), manager: gifManager, loopCount: 100)
        gifImageView.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
        self.navigationItem.title = challenge!.name
        navigationController!.navigationItem.backBarButtonItem?.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if challenge?.gifNames!.count > indexPath.row
        {
            gifImageView.setGifImage(UIImage(gifName: (challenge?.gifNames![indexPath.row])!), manager: gifManager, loopCount: -1)
            gifImageView.startAnimatingGif()
        }
        else {
            gifImageView.image = UIImage(named: (challenge?.tagNames![indexPath.row-(challenge?.gifNames?.count)!])!)
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
            
            videoView.maskView?.hidden = true
            self.navigationController?.navigationBarHidden = true
            self.secondaryBackgroundImageView.hidden = false
            //countdowimageview.hidden = false
            self.countdownImageView.hidden = false
            videoView.hidden = true
            
            self.countdownImageView.setGifImage(UIImage(gifName: "giffy"), manager: gifManager, loopCount: 1)
            view.transform = CGAffineTransformMakeScale(0.01, 0.01);
            
            UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                // animate it to the identity transform (100% scale)
                self.view.transform = CGAffineTransformIdentity;
            }) { (finished) -> Void in
                
                //UIDevice.currentDevice().orientation
                //shouldAutorotate()
                //supportedInterfaceOrientations()
                
                
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
            self.imagePicker.mediaTypes = [kUTTypeMovie as String]
            self.imagePicker.allowsEditing = false
            self.imagePicker.delegate = self
            self.imagePicker.videoMaximumDuration = Double((self.challenge?.timeLimit)!)
            self.videoView.hidden = true
            
            self.presentViewController(self.imagePicker, animated: true, completion: {})
                }
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("video recorded")
        secondaryBackgroundImageView.hidden = true
        countdownImageView.hidden = true
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
            self.pickedVideo = pickedVideo
    
        }
        
        imagePicker.dismissViewControllerAnimated(true) {
            self.performSegueWithIdentifier("responseSegue", sender: self)
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
