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
    var completedBy: [String]? = []
    var gifNames: [String]? = []
    var tagNames: [String]? = []
    var cTagNames: [String]? = []
    var deadline: NSDate?
    var startDate: NSDate?
    var timeLimit: Int?
    var senderID: String?
    var name: String?
    var videoLikes: [Int]?
    var videoURLs: [String]?
    
    // Complete initializer for FB retrieval
    init (name: String, workout_gifs: [String], add_on_images: [String], time_limit: Int, participants: [String], challengeID: String, comp_tags: [String], deadline: String, senderID: String, completedBy: [String], videoLikes: [Int], videoURLs: [String], startDate: String) {
        self.name = name
        self.gifNames = workout_gifs
        self.tagNames = add_on_images
        self.cTagNames = comp_tags
        self.timeLimit = time_limit
        self.participants = participants
        self.challengeID = challengeID
        self.deadline = FBClient.dateFormatter.dateFromString(deadline)
        self.senderID = senderID
        self.completedBy = completedBy
        self.videoLikes = videoLikes
        self.videoURLs = videoURLs
        self.startDate = FBClient.dateFormatter.dateFromString(startDate)
    }
    
    init(dict: NSDictionary)
    {
        self.name = dict["name"] as? String
        self.gifNames = dict["workout_gifs"] as? [String]
        self.tagNames = dict["add_on_images"] as? [String]
        self.timeLimit = dict["time_limit"] as? Int
        self.participants = dict["participants"] as? [String]
        self.challengeID = dict["challengeID"] as? String
        self.deadline = dict["deadline"] as? NSDate
        self.senderID = dict["senderID"] as? String
        self.completedBy = dict["completed_by"] as? [String]
        self.videoLikes = dict["video_likes"] as? [Int]
        self.videoURLs = dict["video_URLs"] as? [String]
        self.startDate = FBClient.dateFormatter.dateFromString((dict["start_date"] as? String)!)
        self.deadline = FBClient.dateFormatter.dateFromString((dict["deadline"] as? String)!)
    }
    
    init()
    {
        let challengeID = FBClient.dataRef.child("Challenges").childByAutoId().key
        self.challengeID = challengeID
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
    
    /*func getUsers() -> [User]
    {
        var users: [User] = []
        
        for userID in participants!
        {
            let user = FBClient.getUser(userID)
            users.append(user)
        }
        
        return users

    }*/

    }


