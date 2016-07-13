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
    var participants: [String]?
    var userVideoIDs: [String: String]?
    var deadline: NSDate?
    var gifIDs: [String]?
    var moveIDs: [String]?
    
    
    init(gifIDs: [String], moveIDs: [String], deadline: NSDate, participants: [String])
    {
        self.gifIDs = gifIDs
        self.moveIDs = moveIDs
        self.deadline = deadline
        self.participants = participants
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
            let user = FBClient.getUserFromID(userID)
            
            users.append(user)
        }
        
        return users
    }
    
}
