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
    var challengeID: String?
    var participants: [String]? = []
    var gifNames: [String]? = []
    var tagNames: [String]? = []
    var deadline: NSDate?
    var timeLimit: Int?
    
    
    init()
    {

    }
    
    func addParticipant(userID: String)
    {
        participants?.append(userID)
    }
    
    func removeParticipant(userID: String)
    {
        if let index = participants!.indexOf(userID)
        {
            participants?.removeAtIndex(index)
        }
    }
    
    func chooseDate(deadline: NSDate) //may not need this depending on when we select the date
    {
        self.deadline = deadline
    }
    
    func didPass() -> Bool
    {
        let currentDate = NSDate() //this should get the current date, but verify this later

        if currentDate.compare(deadline!) == NSComparisonResult.OrderedAscending
        {
            return false
        }
        
            else
        {
            return true
        }
    }
    
    func sendToUsers()
    {
        FBClient.uploadChallenge(self)
    }
    
    func getUsers() -> [User]
    {
        var users: [User] = []
        
        for userID in participants!
        {
            let user = FBClient.getUser(userID)
            users.append(user)
        }
        
        return users
    }
    
}
