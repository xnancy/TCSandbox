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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton: FBSDKLoginButton = FBSDKLoginButton()
    @IBOutlet weak var aivLoadingSpinner: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("initialViewController")
                self.presentViewController(homeViewController, animated: true, completion: nil)
            }
            
                else
            {
                // No user is signed in.
                
                self.loginButton.hidden = false
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButton.center = self.view.center
                
                self.loginButton.delegate = self
                
                self.view.addSubview(self.loginButton)
            }
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
