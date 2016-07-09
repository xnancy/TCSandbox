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


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if FBSDKAccessToken.currentAccessToken() == nil
        {
            User.currentUser = nil
        }
        
        else
        {
            if User.currentUser == nil
            {
                //check if this user exists on firebase, if not
                //then add them to firebase and initialize a new user
                //otherwise, pull their info from firebase and initialize
                //a new user
            }
        }
        
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - FACEBOOK LOGIN
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        
        if error == nil
        {
            //check if this user exists on firebase, if not
            //then add them to firebase and initialize a new user
            //otherwise, pull their info from firebase and initialize
            //a new user
            
            
            performSegueWithIdentifier("loginSegue", sender: self)
            FirebaseClient.saveUser()
        }
        
        else
        {
            print(error.localizedDescription)
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        //USER LOGGED OUT
        User.currentUser = nil
    }

}
