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

class ChallengeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var challenge: Challenge?
    var didRespond: Bool?
    var pickedVideo: NSURL?

    var user: User?
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        //create self.challenge from challengeID
        
        self.tabBarController?.tabBar.hidden = true
        
        challengeTitleLabel.text = challenge?.name
        deadlineLabel.text = FBClient.dateFormatter.stringFromDate(challenge!.deadline!)
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

        
        if ((challenge?.completedBy?.contains(FBSDKAccessToken.currentAccessToken().userID)) != nil)
        {
            didRespond = true
        }
        
        else
        {
            didRespond = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.indexLabel.text = "\(indexPath.row)"
        
        return cell
    }
    

    @IBAction func didPressRespond(sender: AnyObject) {
        if didRespond!
        {
            
        }
            
            else
        {
            imagePicker.sourceType = .Camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            imagePicker.videoMaximumDuration = Double((challenge?.timeLimit)!)
            
            presentViewController(imagePicker, animated: true, completion: {})
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("video recorded")
        
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
            self.pickedVideo = pickedVideo
            print(pickedVideo)
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
