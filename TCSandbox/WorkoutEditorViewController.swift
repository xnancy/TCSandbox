//
//  WorkoutEditorViewController.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SnappingStepper
import DGRunkeeperSwitch
import SwiftyGif
import FBSDKCoreKit
import FBSDKLoginKit



class WorkoutEditorViewController: UIViewController {
    
    /* ---------- OUTLETS ---------- */
    
    
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
    @IBOutlet weak var countdownLabelButton: UIButton!
    
    
    
    /* ---------- VARIABLES ---------- */
    var gifmanager = SwiftyGifManager(memoryLimit: 20)
    //var gifsDictionary: Dictionary()
    //var gifsToShow: [String] = []
    var gifsToShow: [String?] = []
    var tagsToShow: [String] = []
    var movesCount: Int!
    var workoutCount: Int!
    var tagsCount: Int!
    //var gifDescriptionsToShow:[String] = []
    // var gifDescriptionsToShow: [String] = []
    // var index = Int()
    //var tagDescroptionToShow: [String] = []
    
    var challenge: Challenge?
    
    
    //var toPass: String!
    
    
    // 0 = Hip Airplane whih is ac 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FBClient.logout()

        //User.updateCurrentUser()
        // Do any additional setup after loading the view.
        //print(movesCount)
        //print (workoutCount)
        //print(tagsToShow)
        
        
        selectedMoveLabel1.text = Gifs.gifDictionary[(gifsToShow[0])!]
        gifSelectedImageView1.image = UIImage(named: gifsToShow[0]!)
        
        
        if workoutCount > 1 {
        
        if workoutCount == 2 {
        selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])!]
        gifSelectedImageView2.image = UIImage(named: gifsToShow[1]!)
        }
        
        else if workoutCount == 3 {
        selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])!]
        gifSelectedImageView2.image = UIImage(named: gifsToShow[1]!)
        selectedMoveLabel3.text = Gifs.gifDictionary[(gifsToShow[2])!]
        gifSelectedImageView4.image = UIImage(named: gifsToShow[2]!)
        }
        
        else if workoutCount == 4 {
        selectedMoveLabel2.text = Gifs.gifDictionary[(gifsToShow[1])!]
        gifSelectedImageView2.image = UIImage(named: gifsToShow[1]!)
        selectedMoveLabel3.text = Gifs.gifDictionary[(gifsToShow[2])!]
        gifSelectedImageView4.image = UIImage(named: gifsToShow[2]!)
        selectedMoveLabel4.text = Gifs.gifDictionary[(gifsToShow[3])!]
        gifSelectedImageView3.image = UIImage(named: gifsToShow[3]!)
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
//                selectedMoveLabel4.text = Tags.tagDictionary[tagsToShow[2]]
//                gifSelectedImageView3.image = UIImage(named: tagsToShow[2])

            }
    
        }
        else if workoutCount == 3 {
            selectedMoveLabel4.text = Tags.tagDictionary[tagsToShow[0]]
            gifSelectedImageView3.image = UIImage(named: tagsToShow[0])
            
        }
        
        }
       
        
       
        
        //        */
        //print(index)
        //print(gifsToShow)
        ///print(gifDescriptionsToShow)
        
        
        //challenge = Challenge()
        
        //print(challenge?.challengeName)
        // selectedMoveLabel1.text = gifsToShow[0]
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func didLogout(sender: AnyObject) {
        
        User.currentUser = nil
        //FirebaseClient.logout()
        
        FBClient.logout()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
        
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
