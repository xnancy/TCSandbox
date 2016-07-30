//
//  LoginViewController.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import AlertOnboarding
import SwiftyGif

class LoginViewController: UIViewController,
 FBSDKLoginButtonDelegate, AlertOnboardingDelegate {
    
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    var loginButton: FBSDKLoginButton = FBSDKLoginButton()
    
    @IBOutlet weak var aivLoadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var btnSignUpwithFaceBook: UIButton!
    @IBOutlet weak var btnRegisterwithFaceBook: UIButton!
    @IBOutlet weak var loadingScreenGifImage: UIImageView!
    override func viewDidLoad()
    {
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if FBSDKAccessToken.currentAccessToken() != nil {
                //User is signed in.
                User.updateCurrentUser()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("initialViewController")
                self.presentViewController(homeViewController, animated: false, completion: nil)
            }
            else
            {
                
            }
            
            super.viewDidLoad()
            
            self.loadingScreenGifImage.setGifImage(UIImage(gifName: "loading"), manager: self.gifManager, loopCount: -1)
            self.alertView = AlertOnboarding(arrayOfImage: self.arrayOfImage, arrayOfTitle: self.arrayOfTitle, arrayOfDescription: self.arrayOfDescription)
            self.alertView.delegate = self
            
        }

 

    }
    var alertView: AlertOnboarding!
    
    var arrayOfImage = ["crawl", "done", "zombie", "scream"]
    var arrayOfTitle = ["CREATE AN ACCOUNT", "ADD YOUR FRIENDS", "CREATE A CHALLENGE", "RECORD AND SHARE"]
    var arrayOfDescription = [
        
        "Sign Up for TapeRace with your Facebook account! If you dont have a Facebook account, you can make one by clicking the 'Register with Facebook' button on our login screen.",
        
        "Add your friends to see their challenges in your feed as well as to send them awesome challenges you create. Once they're your friends in the app, they can send you sweet challenges too!",
        
        "To create a challenge, click on the plus sign icon and choose from over 200 different moves and tags. Choose at least one move to base your challenge and add tags to spice it up!",
        
        "After creating your challenge, record a video of yourself completing the challenge then select friends to share it with. Then TAAAADAAA, You've created a challenge!!!"
    
    ]
  
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
 
    
    @IBAction func onTouch(sender: AnyObject) {
        
        /*
         //IF YOU WANT TO CUSTOM ALERTVIEW
         self.alertView.colorForAlertViewBackground = UIColor(red: 173/255, green: 206/255, blue: 183/255, alpha: 1.0)
         self.alertView.colorButtonText = UIColor.whiteColor()
         self.alertView.colorButtonBottomBackground = UIColor(red: 65/255, green: 165/255, blue: 115/255, alpha: 1.0)
         
         
         
         
         
        */
         self.alertView.colorPageIndicator = UIColor.grayColor()
         self.alertView.colorCurrentPageIndicator = UIColor.blueColor()
         self.alertView.colorTitleLabel = UIColor.whiteColor()
         self.alertView.colorDescriptionLabel = UIColor.whiteColor()
         self.alertView.percentageRatioHeight = 0.94
         self.alertView.percentageRatioWidth = 0.9
        
         self.alertView.show()
        
    }
    
    //--------------------------------------------------------
    // MARK: DELEGATE METHODS --------------------------------
    //--------------------------------------------------------
    
    func alertOnboardingSkipped(currentStep: Int, maxStep: Int) {
        //print("Onboarding skipped the \(currentStep) step and the max step he saw was the number \(maxStep)")
    }
    
    func alertOnboardingCompleted() {
        //print("Onboarding completed!")
    }
    
    func alertOnboardingNext(nextStep: Int) {
        //print("Next step triggered! \(nextStep)")
    }

   
    override func viewDidAppear(animated: Bool) {
        //setup(["1View","2View","3View","4View","5View"])
        
        //view.bringSubviewToFront(beginButtonView)
    }
    
    
    
    @IBAction func fbRegisterwithFB(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/r.php")!)
        
    }
    
    
    
    @IBAction func fbLoginInitiate() {
        let loginManager = FBSDKLoginManager()
        self.loadingScreenGifImage.hidden = false
        loginManager.logInWithReadPermissions(["public_profile", "email"], handler: {(result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            
            if (error != nil) {
                // Process error
                self.removeFbData()
            } else if result.isCancelled {
                // User Cancellation
                self.removeFbData()
            } else {
                //Success
                if result.grantedPermissions.contains("email") && result.grantedPermissions.contains("public_profile") {
                    //Do work
                    FBClient.login()
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("initialViewController")
                    self.presentViewController(homeViewController, animated: false, completion: nil)
                    //self.fetchFacebookProfile()
                } else {
                    //Handle error
                }
            }
        })
    }
    
    
    func removeFbData() {
        //Remove FB Data
        let fbManager = FBSDKLoginManager()
        fbManager.logOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
    
    func fetchFacebookProfile(){
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil) {
                    //Handle error
                } else {
                    //Handle Profile Photo URL String
                    let userId =  result["id"] as! String
                    //let profilePictureUrl = "https://graph.facebook.com/\(id)/picture?type=large"
                    
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    let fbUser = ["accessToken": accessToken, "user": result]
                    
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - FACEBOOK LOGIN
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {        
        self.loginButton.hidden = true
        aivLoadingSpinner.startAnimating()
        
        if error == nil
        {
            FBClient.login()
        }
            else if result.isCancelled
        {
            //code to handle the cancelled case
            self.loginButton.hidden = false
            aivLoadingSpinner.stopAnimating()
        }
        
            else
        {
            print(error.localizedDescription)
            self.loginButton.hidden = false
            aivLoadingSpinner.stopAnimating()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        FBClient.logout()
    }

}
