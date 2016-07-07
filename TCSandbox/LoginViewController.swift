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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if FBSDKAccessToken.currentAccessToken() == nil
        {
            //NOBODY IS LOGGED IN
        }
        
        else
        {
            User.updateCurrentUser()
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
            //LOGIN WAS SUCCESSFUL
            
            
            performSegueWithIdentifier("loginSegue", sender: self)
            User.updateCurrentUser()
        }
        
        else
        {
            print(error.localizedDescription)
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        //USER LOGGED OUT
        
    }

}
