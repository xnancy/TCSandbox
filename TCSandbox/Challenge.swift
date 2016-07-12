//
//  Challenge.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/7/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation

class Challenge: AnyObject
{
    var videoID: String?
    var participants: [String]?
    // userID String: videoID String
    var userVideoIDs: [String: String]?
    var deadline: NSDate?
    var past: Bool?
    
    init()
    {
        
    }
    
    func addUser(userID: String)
    {
        participants?.append(userID)
    }
    
    func removeUser(userID: String)
    {
        if let index = participants!.indexOf(userID)
        {
            participants?.removeAtIndex(index)
        }
    }
    
    func didPass() -> Bool
    {
//        let dateComponents = NSDateComponents()
//        let currentYear = dateComponents.year
//        let currentMonth = dateComponents.month
//        let currentDay = dateComponents.day
//        let currentHour = dateComponents.hour
//        let currentMin = dateComponents.minute
//        
//        let dueYear = deadline.
        
        return true //CHANGE THIS
    }
    
    func sendToUsers()
    {
    
    }
    
    func getUsers() -> [User]
    {
        var users: [User] = []
        
        for userID in participants!
        {
            let user = FBClient.getUserFromID(userID)
            
            users.append(user)
        }
        
        return users
    }
    
}
