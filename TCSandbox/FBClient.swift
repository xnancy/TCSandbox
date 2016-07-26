//
//  FBClient.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class FBClient: AnyObject {
    static let dataRef = FIRDatabase.database().reference()
    static let dateFormatter = NSDateFormatter()
    static let navigationController = UINavigationController()
    class func initializeDateFormatter() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    }
    static let storageRef = FIRStorage.storage().reference()
    
    class func login()
    {
        //facebook authentication in Firebase
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        let parameters = ["fields": "email, name, id, picture.type(large)"]
        
        // FB get current user
        let request = FBSDKGraphRequest(graphPath: "me", parameters: parameters, tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
        
        // POST current user to Firebase
        request.startWithCompletionHandler({ (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError)
                return
            }
            
            dataRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                let FBID = FBSDKAccessToken.currentAccessToken().userID
                var pictureUrl = ""
                
                if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                    pictureUrl = url
                }
                
                let email = user["email"] as! String
                let profileImageURLString = pictureUrl
                let name = user["name"] as! String
                
                if snapshot.hasChild(FBID)
                {
                    let friendsList = snapshot.value![FBID]!!["friends_list"] as! [String]
                    
                    let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, name: name, friends: friendsList)
                    User.currentUser = currentUser
                }
                    
                else
                {
                    let friendsList: [String] = [FBID]
                    let challenges: [String] = ["placeholder"]
                    let challengesCompleted: Int = 0
                    let feedDictionary: NSDictionary = ["placeholder": "placeholder"]
                    let feedChallenges: [String] = ["placeholder"]
                    let likeCount = 0
                    let votedOn = ["placeholder"]
                    let updates = ["FBID": FBID, "email": email, "name": name, "profile_picture_url": profileImageURLString, "friends_list": friendsList, "challenges": challenges, "challenges_completed": challengesCompleted, "feed_challenges": feedChallenges, "feed_dictionary": feedDictionary, "like_count": likeCount, "voted_on": votedOn]
                    
                    dataRef.child("Users").child(FBID).updateChildValues(updates as [NSObject : AnyObject])
                    
                    let currentUser = User(FBID: FBID, email: email, profileImageURLString: profileImageURLString, name: name, friends: friendsList)
                    User.currentUser = currentUser
                }
            })
            
            { (error) in
                
                print(error.localizedDescription)
            }
        })
    }
    
    class func logout()
    {
        FBSDKAccessToken.setCurrentAccessToken(nil)
        User.currentUser = nil
        try! FIRAuth.auth()!.signOut()
    }
    
    
    
    class func retrieveChallengeFromID (challengeID: String, completion: (Challenge) -> Void) {
        var tempChallenge: Challenge?
        dataRef.child("Challenges").child(challengeID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            tempChallenge = Challenge(dict: snapshot.value as! NSDictionary)

            completion(tempChallenge!)
        })
    }

    
    class func retrieveUserFromID (userID: String, completion: (User) -> Void) {
        var user: User?
        dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            user = User(dict: snapshot.value as! NSDictionary)
            
            completion(user!)
        })
        
    }
    
    class func retrievePictureForUser (userID: String, completion: (String) -> Void) {
        dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            let url = snapshot.value!["profile_picture_url"] as! String
            
            completion(url)
        })
        
    }
    

    class func addFriend(friendID: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        dataRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let userDict = snapshot.value![FBID]
            var userFriendsList = userDict!!["friends_list"] as! [String]
            
            let friendDict = snapshot.value![friendID]
            var friendFriendsList = friendDict!!["friends_list"] as! [String]
            
            userFriendsList.append(friendID)
            friendFriendsList.append(FBID)
            
            let userUpdates = ["friends_list": userFriendsList]
            let friendUpdates = ["friends_list": friendFriendsList]
            
            dataRef.child("Users").child(FBID).updateChildValues(userUpdates)
            dataRef.child("Users").child(friendID).updateChildValues(friendUpdates)

            
            User.currentUser?.friends = userFriendsList
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    
    class func removeFriend(friendID: String)
    {
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        
        dataRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            let userDictionary = snapshot.value![FBID]
            let friendDictionary = snapshot.value![friendID]
            
            var userFriendsList = userDictionary!!["friends_list"] as! [String]
            var friendFriendsList = friendDictionary!!["friends_list"] as! [String]
            
            if let index = friendFriendsList.indexOf(FBID)
            {
                friendFriendsList.removeAtIndex(index)
                let updates = ["friends_list": friendFriendsList]
                dataRef.child("Users").child(friendID).updateChildValues(updates)
            }
            
            if let index = userFriendsList.indexOf(friendID)
            {
                userFriendsList.removeAtIndex(index)
                let updates = ["friends_list": userFriendsList]
                dataRef.child("Users").child(FBID).updateChildValues(updates)
                User.currentUser?.friends = userFriendsList
            }
            
            
        })  { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    // Asynchronously retrieves challenges for the current user from the backend and performs the completion block on the result as an array of Challenge objects
    class func retrieveChallenges(completion: ([Challenge]) -> Void) {
        print("access: \(FBSDKAccessToken.currentAccessToken().userID)")
        dataRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let challengeIDs = snapshot.value!["Users"]!![FBSDKAccessToken.currentAccessToken().userID]!!["challenges"] as! [String]
            var challenges: [Challenge] = []
            print("challenge IDs count is: \(challengeIDs.count))")
            if challengeIDs.count > 1 {
                for i in 1...challengeIDs.count - 1 {
                    let id = challengeIDs[i]
                    let newChallengeDictionary = snapshot.value!["Challenges"]!![id] as! NSDictionary
                    let newChallengeObject = Challenge(name: newChallengeDictionary["name"] as! String, workout_gifs: newChallengeDictionary["workout_gifs"] as! [String], add_on_images: newChallengeDictionary["add_on_images"] as! [String], time_limit: newChallengeDictionary["time_limit"] as! Int, participants: newChallengeDictionary["participants"] as! [String], challengeID: newChallengeDictionary["challengeID"] as! String, comp_tags: newChallengeDictionary["comp_tags"] as! [String], deadline: newChallengeDictionary["deadline"] as! String, senderID: newChallengeDictionary["senderID"] as! String, completedBy: newChallengeDictionary["completed_by"] as! [String], videoLikes: newChallengeDictionary["video_likes"] as! [Int], videoURLs: newChallengeDictionary["video_URLs"] as! [String])
                    challenges.append(newChallengeObject)
                    
                }
            }
            completion(challenges)

        },
        withCancelBlock: { error in print(error.description) })
    }
    
    class func uploadChallenge(challenge: Challenge)
    {
        let challengeID = challenge.challengeID
        let senderID = FBSDKAccessToken.currentAccessToken().userID
        let participants = challenge.participants
        let gifNames = challenge.gifNames
        let deadline = challenge.deadline
        var tagNames = challenge.tagNames
        let timeLimit = challenge.timeLimit
        let compTags = challenge.cTagNames
        let challengeName = challenge.name
        let completedBy = ["placeholder"]
        let videoLikes = [0]
        challenge.completedBy = ["placeholder"]

        
        if tagNames! == [] {
            tagNames = ["placeholder"]
            
        }
        

        for userID in participants!
        {
            
            //add challenge to user in firebase and user's current challenges
            dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                
                var challenges = snapshot.value!["challenges"] as! [String]
                challenges.append(challengeID!)

                
                let updates = ["challenges": challenges]
                dataRef.child("Users").child(userID).updateChildValues(updates)
                
                //GO THROUGH USER FRIENDS LIST INCLUDING USER AND APPEND CHALLENGE TO EACH PERSON'S FEED ARRAY/DICTIONARY
                let friendsList = snapshot.value!["friends_list"] as! [String]
                
                for friendID in friendsList
                {
                    dataRef.child("Users").child(friendID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                        
                        var feedChallenges = snapshot.value!["feed_challenges"] as! [String]
                        var feedDictionary = snapshot.value!["feed_dictionary"] as! [String: String]
                        
                        if feedChallenges[0] != "placeholder"
                        {
                            feedChallenges.append(challengeID!)
                        }
                        
                        else
                        {
                            feedChallenges[0] = challengeID!
                        }
                        
                        feedDictionary.updateValue(dateFormatter.stringFromDate(deadline!), forKey: challengeID!)
                        
                        
                        let updates = ["feed_challenges": feedChallenges, "feed_dictionary": feedDictionary]
                        dataRef.child("Users").child(friendID).updateChildValues(updates as [NSObject : AnyObject])
                    })
                }
                
                
                
            })  { (error) in
                
                print(error.localizedDescription)
            }

            dataRef.child("Challenges").child(challengeID!).updateChildValues(["participants": participants!, "workout_gifs": gifNames!, "add_on_images": tagNames!, "time_limit": timeLimit!,"comp_tags": compTags!, "challengeID": challengeID!, "deadline": FBClient.dateFormatter.stringFromDate(deadline!), "name": challengeName!, "senderID": senderID, "completed_by": completedBy, "video_likes": videoLikes, "start_date": dateFormatter.stringFromDate(NSDate())])
        }
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewControllerWithIdentifier("MyChallengesVC")
        self.navigationController.presentViewController(homeVC, animated: false, completion: nil)
        self.navigationController.dismissViewControllerAnimated(false, completion: nil)
    }
    
    class func declineChallenge(challenge: Challenge)
    {
        //ALSO REMOVE FROM FEED
        let FBID = FBSDKAccessToken.currentAccessToken().userID
        let challengeID = challenge.challengeID
        
        dataRef.child("Users").child(FBID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            var participants = challenge.participants
            var challenges = snapshot.value!["challenges"] as! [String]
            let indexOfChallenge = challenges.indexOf(challengeID!)
            let indexOfUser = participants!.indexOf(FBID)
            challenges.removeAtIndex(indexOfChallenge!)
            participants!.removeAtIndex(indexOfUser!)
            
            dataRef.child("Users").child(FBID).updateChildValues(["challenges": challenges])
            dataRef.child("Challenges").child(challengeID!).updateChildValues(["participants": participants!])
            
        })  { (error) in
            print(error.localizedDescription)
        }
    }
    
    /* ---------- FRIENDS/USERS ---------- */
    // Creates a closure callback that continually updates a user's friends ID list in a user object
    class func updateFriends(user: User, completion: ([String]) -> Void) {
        // Attach a closure to read the data at our posts reference
        dataRef.child("Users").child(user.FBID!).observeSingleEventOfType(.Value, withBlock: { snapshot in
            user.friends = []
            for friend in snapshot.value!["friends_list"] as! [String] {
                user.friends?.append(friend)
            }
            completion(user.friends!)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    /* ---------- FRIEND CELL GENERATION ---------- */
    class func generateFriendCell(friendID: String, cell: FriendsSendChallengeTableViewCell) {
        
        dataRef.childByAppendingPath("Users").childByAppendingPath(friendID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let url = NSURL(string: dict["profile_picture_url"] as! String)
            cell.userProfileImageView.setImageWithURL(url!)
            cell.userNameLabel.text = dict["name"] as! String
            cell.userChallengeCompletedLabel.text = "Challenges Completed: \(dict["challenges_completed"] as! NSNumber)"
        })
    }
    
    class func generateFriendSearchCell(friendID: String, cell: searchFriendsTableViewCell) {
        dataRef.childByAppendingPath("Users").childByAppendingPath(friendID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let url = NSURL(string: dict["profile_picture_url"] as! String)
            cell.profileImageView.setImageWithURL(url!)
            cell.nameTextLabel.text = dict["name"] as! String
            cell.challengesCompletedLabel.text = "Completed: \(dict["challenges_completed"] as! NSNumber)"
        })
    }
    
    /* ---------- CHALLENGE CELL GENERATION ---------- */
    class func generateChallengeCell(challenge: Challenge, cell: myChallengeTableViewCell) {
        dataRef.childByAppendingPath("Users").childByAppendingPath(challenge.senderID!).observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let userName = dict["name"] as! String
            let userProfileURL = NSURL(string: dict["profile_picture_url"] as! String)
            cell.challengeNameLabel.text = challenge.name
            cell.profileImageView.setImageWithURL(userProfileURL!)
            cell.senderNameLabel.text = userName
            // Calculating timestamp for challenge
            let minutesToDeadline = challenge.deadline?.minutes(from: NSDate())
            let hoursToDeadline = challenge.deadline?.hours(from: NSDate())
            let daysToDeadline = challenge.deadline?.days(from: NSDate())
            if (minutesToDeadline < 1) {
                cell.timeLimitLabel.text = ""
            } else if (minutesToDeadline < 60) {
                cell.timeLimitLabel.text = String(minutesToDeadline!) + " mins"
            } else if (hoursToDeadline < 24) {
                cell.timeLimitLabel.text = String(hoursToDeadline!) + " hrs"
            } else {
                cell.timeLimitLabel.text = String(daysToDeadline!) + " days"
                print(cell.timeLimitLabel.text)
            }
        })
    }
    
    /* ---------- GENERAL LISTS ---------- */
    // Fills [String: String] with list of all userID: name in database
    class func generateNonFriendUserIDList(dictionary: NSMutableDictionary, delegate: AddFriendViewControllerDelegate) {
        dataRef.childByAppendingPath("Users").observeSingleEventOfType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            let currentUserID = FBSDKAccessToken.currentAccessToken().userID
            let friendsList = dict.valueForKey(currentUserID)?.valueForKey("friends_list") as! [String]
            for element in dict.allKeys as! [String] {
                let id = dict[element]!["FBID"] as! String
                if (!friendsList.contains(id)) {
                    dictionary.setValue(dict[element]!["name"] as! String, forKey: dict[element]!["FBID"] as! String)
                }
            }
            delegate.reloadFriendTable()
        })
    }
    
    class func uploadVideo(pickedVideo: NSURL, challenge: Challenge)
    {
        
        let userVideoRef = FBClient.storageRef.child(FBSDKAccessToken.currentAccessToken().userID)
        let videoRef = userVideoRef.child((challenge.challengeID)!)
        
        let uploadTask = videoRef.putFile(pickedVideo, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                let downloadURLString = downloadURL?.absoluteString

                //save the string to the array in challenges
                //stream the video from the download URL on the screen
                var completedBy = challenge.completedBy!
                
                
                if completedBy == ["placeholder"]
                {
                    completedBy = [FBSDKAccessToken.currentAccessToken().userID]
                }
                
                else
                {
                    completedBy.append(FBSDKAccessToken.currentAccessToken().userID)
                }
                
                var videoLikes = challenge.videoLikes
                videoLikes?.append(0)
                if videoLikes == nil
                {
                    videoLikes = [0]
                }
                
                var videoURLs = challenge.videoURLs
                videoURLs?.append(downloadURLString!)
                if videoURLs == nil
                {
                    videoURLs = [downloadURLString!]
                }
            
                let updates: NSDictionary = ["completed_by": completedBy, "video_likes": videoLikes!, "video_URLs": videoURLs!]
                dataRef.child("Challenges").child(challenge.challengeID!).updateChildValues(updates as [NSObject : AnyObject])
                
                dataRef.child("Users").child(FBSDKAccessToken.currentAccessToken().userID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                    
                    var challengesCompleted = snapshot.value!["challenges_completed"] as! Int
                    let updates = ["challenges_completed": challengesCompleted+1]
                    dataRef.child("Users").child(FBSDKAccessToken.currentAccessToken().userID).updateChildValues(updates)
                })
            }
        }
    }
    
    class func downloadVideo(challengeID: String, userID: String, completion: (NSURL) -> Void)
    {
        let videoRef = storageRef.child(userID).child(challengeID)
        
        videoRef.downloadURLWithCompletion { (URL, error) -> Void in
            if (error != nil) {
                // Handle any errors
                print(error?.localizedDescription)
            } else {
                completion(URL!)
            }
        }
    }
    
    class func retrieveFeed(completion: ([String], [String: String]) -> Void)
    {
        dataRef.child("Users").observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if snapshot.hasChild(FBSDKAccessToken.currentAccessToken().userID)
            {
                let feedDictionary = snapshot.value![FBSDKAccessToken.currentAccessToken().userID]!!["feed_dictionary"] as! [String: String]
                let feedChallenges = snapshot.value![FBSDKAccessToken.currentAccessToken().userID]!!["feed_challenges"] as! [String]
                
                completion(feedChallenges, feedDictionary)
            }
            
            else
            {
                let feedDictionary: NSDictionary = [:]
                let feedChallenges: [String] = []
                
                completion(feedChallenges, feedDictionary as! [String : String])
            }
        })
    }
    
    class func binarySearch(date: NSDate, array: [String], dictionary: [String: String]) -> Int
    {
        var low = 0
        var high = array.count-1
        
        while low != high
        {
            let mid = (low+high)/2
            
            if (date.compare(FBClient.dateFormatter.dateFromString((dictionary[array[mid]])!)!) == NSComparisonResult.OrderedAscending)
            {
                low = mid + 1
            }
            
            else
            {
                high = mid
            }
        }
        
        return low
    }
    
    class func likeVideo(userID: String, challengeID: String, index: Int, videoURL: String)
    {
        dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var likesCount = snapshot.value!["like_count"] as! Int
            likesCount = likesCount + 1
            
            dataRef.child("Users").child(userID).updateChildValues(["like_count":likesCount])
        })
        
        
        
        dataRef.child("Challenges").child(challengeID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var likesCountArray = snapshot.value!["video_likes"] as! [Int]
            var likesCount = likesCountArray[index] + 1
            likesCountArray[index] = likesCount
            
            dataRef.child("Challenges").child(challengeID).updateChildValues(["video_likes":likesCountArray])
        })
        
        
    }
    
    class func unlikeVideo(userID: String, challengeID: String, index: Int, videoURL: String)
    {
        dataRef.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var likesCount = snapshot.value!["like_count"] as! Int
            likesCount = likesCount - 1
            
            dataRef.child("Users").child(userID).updateChildValues(["like_count":likesCount])
        })
        
        
        
        dataRef.child("Challenges").child(challengeID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var likesCountArray = snapshot.value!["video_likes"] as! [Int]
            var likesCount = likesCountArray[index] - 1
            likesCountArray[index] = likesCount
            
            dataRef.child("Challenges").child(challengeID).updateChildValues(["video_likes":likesCountArray])
        })
        
        
    }
    
    class func tappedLike(userID: String, challengeID: String, videoURL: String, index: Int, completion: (Bool) -> Void)
    {
        dataRef.child("Users").child(FBSDKAccessToken.currentAccessToken().userID).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var votedOn = snapshot.value!["voted_on"] as! [String]
            var hasLiked = false

            if votedOn.contains(videoURL)
            {
                let votedIndex = votedOn.indexOf(videoURL)
                votedOn.removeAtIndex(votedIndex!)
                FBClient.unlikeVideo(userID, challengeID: challengeID, index: index, videoURL: videoURL)
                hasLiked = true
            }
            
            else
            {
                votedOn.append(videoURL)
                FBClient.likeVideo(userID, challengeID: challengeID, index: index, videoURL: videoURL)
            }

            dataRef.child("Users").child(FBSDKAccessToken.currentAccessToken().userID).updateChildValues(["voted_on":votedOn])

            completion(hasLiked)
        })
    }
}
