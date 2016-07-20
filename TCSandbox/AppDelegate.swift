//
//  AppDelegate.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var shortcutItem: UIApplicationShortcutItem?
    
    override init() {
        super.init()
        FBClient.initializeDateFormatter()
        FIRApp.configure()
        // not really needed unless you really need it FIRDatabase.database().persistenceEnabled = true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        // Override point for customization after application launch. 
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }

        //Go BACK LATER
        //return performShortcutDelegate 
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //FBSDKAppEvents.activateApp()
        print("Application did become active")
        
        guard let shortcut = shortcutItem else { return }
        
        print("- Shortcut property has been set")
        
        handleShortcut(shortcut)
        
        self.shortcutItem = nil
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        print("Handling shortcut")
        
        var succeeded = false
        
        if( shortcutItem.type == "com.tcsandbox.addfriends" ) {

            print("- Handling \(shortcutItem.type)")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let addFriendsVC = sb.instantiateViewControllerWithIdentifier("AddFriendsVC") as! AddFriendViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            print("addfriends tapped")
            root?.presentViewController(addFriendsVC, animated: false, completion: {
            })
            succeeded = true
            
        } else

        if( shortcutItem.type == "com.tcsandbox.newchallenge" ) {
            
            print("- Handling \(shortcutItem.type)")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let MakeChallengeVC = sb.instantiateViewControllerWithIdentifier("MoveScrollViewController") as! MoveScrollViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            print("newchallenges tapped")
            root?.presentViewController(MakeChallengeVC, animated: false, completion: {
            })
            succeeded = true
            
        } else

        if let tabVC = self.window?.rootViewController as? UITabBarController {
            
            if( shortcutItem.type == "com.tcsandbox.challenges" ){
                tabVC.selectedIndex = 1
                print("challenges tapped")
            }
            
        }

        
        return succeeded
        
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        print("Application performActionForShortcutItem")
        completionHandler( handleShortcut(shortcutItem) )
        
    }
}

