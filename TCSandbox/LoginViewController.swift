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
    
    @IBOutlet weak var outlet: UIButton!
    @IBOutlet weak var aivLoadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var btnSignUpwithFaceBook: UIButton!
    @IBOutlet weak var btnRegisterwithFaceBook: UIButton!
    @IBOutlet weak var loadingScreenGifImage: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        loadingScreenGifImage.setGifImage(UIImage(gifName: "loading"), manager: gifManager, loopCount: -1)

        
        alertView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
        alertView.delegate = self
        
        
        
        //
//        FBClient.logout()
//        FBClient.initializeDateFormatter()
//            FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
//            if FBSDKAccessToken.currentAccessToken() != nil {
//                //User is signed in.
//                //User.updateCurrentUser()
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let homeViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("initialViewController")
//                self.presentViewController(homeViewController, animated: false, completion: nil)
//            }
//            else
//            {
//                // No user is signed in.
//                self.loginButton.hidden = false
////                let loginView : FBSDKLoginButton = FBSDKLoginButton()
////                self.view.addSubview(loginView)
////                loginView.center = self.btnSignUpwithFaceBook.center
////                loginView.frame.size.width = self.btnSignUpwithFaceBook.frame.width
////                loginView.frame.size.height = self.btnSignUpwithFaceBook.frame.height
////                loginView.frame.origin.x = self.btnSignUpwithFaceBook.frame.origin.x
////                loginView.frame.origin.y = self.btnSignUpwithFaceBook.frame.origin.y
//                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
//                self.loginButton.center = self.view.center
//        
//                self.loginButton.delegate = self
//                
//                self.view.addSubview(self.loginButton)
//            }
//        }
    }
    var alertView: AlertOnboarding!
    
    var arrayOfImage = ["image1", "image2", "image3"]
    var arrayOfTitle = ["CREATE ACCOUNT", "CHOOSE THE PLANET", "DEPARTURE"]
    var arrayOfDescription = ["In your profile, you can view the statistics of its operations and the recommandations of friends",
                              "Purchase tickets on hot tours to your favorite planet and fly to the most comfortable intergalactic spaceships of best companies",
                              "In the process of flight you will be in cryogenic sleep and supply the body with all the necessary things for life"]
    
 
    
    @IBAction func onTouch(sender: AnyObject) {
        
        
        /*
         //IF YOU WANT TO CUSTOM ALERTVIEW
         self.alertView.colorForAlertViewBackground = UIColor(red: 173/255, green: 206/255, blue: 183/255, alpha: 1.0)
         self.alertView.colorButtonText = UIColor.whiteColor()
         self.alertView.colorButtonBottomBackground = UIColor(red: 65/255, green: 165/255, blue: 115/255, alpha: 1.0)
         
         self.alertView.colorTitleLabel = UIColor.whiteColor()
         self.alertView.colorDescriptionLabel = UIColor.whiteColor()
         
         self.alertView.colorPageIndicator = UIColor.whiteColor()
         self.alertView.colorCurrentPageIndicator = UIColor(red: 65/255, green: 165/255, blue: 115/255, alpha: 1.0)
         
         //self.alertView.percentageRatioHeight = 0.5
         //self.alertView.percentageRatioWidth = 0.5
         
    */
        
        
        self.alertView.show()
        
    }
    
    //--------------------------------------------------------
    // MARK: DELEGATE METHODS --------------------------------
    //--------------------------------------------------------
    
    func alertOnboardingSkipped(currentStep: Int, maxStep: Int) {
        print("Onboarding skipped the \(currentStep) step and the max step he saw was the number \(maxStep)")
    }
    
    func alertOnboardingCompleted() {
        print("Onboarding completed!")
    }
    
    func alertOnboardingNext(nextStep: Int) {
        print("Next step triggered! \(nextStep)")
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
    
        loginManager.logInWithReadPermissions(["public_profile", "email"], handler: {(result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            
            self.loadingScreenGifImage.hidden = false
            
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

    
//    
//    @IBAction func fbLoginBtn(sender: AnyObject) {
//        
//        let permisions = ["public_profile", "email"]
//        
//        PFFacebookUtils.logInInBackgroundWithReadPermissions(permisions) {
//            (user: PFUser?, error: NSError?) -> Void in
//            
//            if let error = error {
//                print(error)
//            } else {
//                if let user = user {
//                    print(user)
//                    
//                    // "yourSegue" below will be the segue identifier for your new view.
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let homeViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("initialViewController")
//                    self.presentViewController(homeViewController, animated: false, completion: nil)
//                }
//            }
//        }
//    }
    
    
    
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
