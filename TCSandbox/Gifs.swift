import Foundation
import UIKit


class Gifs
{
    // var imageName: String!
    
    var featuredImage: UIImage!
    
    var description = ""
    
    static let gifDictionary: [String: String] = [
        "jump rope": "Jump Rope",
        "hipairplane": "Hip Airplane",
        "pushups": "Push Ups",
        "wallsit": "Wall Sit",
        
        
        "boxing": "Boxing",
        "pullups": "Pull Ups",
        "running": "Running",
        "lifting": "Lifting",
        
        "windshieldwipers": "Windshield Wipers",
        "stepups": "Step Ups",
        "jumpingjacks": "Jumping Jacks"
    ]
    
    static let row1: [String] = [
        "jump rope", "hipairplane", "pushups", "pullups"
    ]
    static let row2: [String] = [
        
        "wallsit","boxing", "running", "lifting", "windshieldwipers", "stepups", "jumpingjacks"    ]
    
    init (featuredImage: UIImage!, description: String){
        
        
        self.featuredImage = featuredImage
        self.description = description
        
    }
    
    //MARK: Private
    
    static func createGifs() -> [Gifs]
    {
        var gifs: [Gifs] = []
        for name in row1 {
            let new = Gifs(featuredImage: UIImage(named: name)!, description: gifDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    static func createGifs2() -> [Gifs]
    {
        var gifs: [Gifs] = []
        for name in row2 {
            let new = Gifs(featuredImage: UIImage(named: name)!, description: gifDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
}

class Tags
{
    //var imageName: String!
    
    var featuredImage: UIImage!
    
    var description = ""
    
    static let tagDictionary: [String: String] = [
        "fullplank": "Superman",
        "leglift": "Lying Down Leg Raises",
        "legraise": "Seated Leg Pull Ins",
        "plankarm": "Plank With Arm Raise",
        "plankraise": "T Plank With Twist",
        "mompushup": "Elevated Push Ups",
        "manpushup": "Elevated Plank",
        "mountainclimbers": "Mountain Climbers",
        "airbike": "Airbike",
        
        "ballmove": "Forward Lunge with Twist",
        "ballwhirl": "Big Arm Circles",
        "burpee": "Plank Pull Ins",
        "buttkickers": "Buttkickers",
        "ropepull": "Standing Row",
        
        "stepover": "Side to Side Hops",
        "weightdrop": "Romanian Deadlift",
        "weightlift": "Reverse Lunge with Overhead Press",
        "weightrock": "Plie Squat with V Raise",
        
        
        "momablift": "Ab Lift with Extended Leg",
        "mombackballroll": "Backward Ball Roll",
        "mombackleglift": "Backward Leg Lift",
        "mombacklift": "Reverse Elevated Push Ups",
        
        "mombackplankleglift": "Reverse Plank Leg Lift",
        "momballroll": "Forward Ball Roll",
        "momballsquat": "Ball Squat",
        "momcrossjump": "Cross Jump",
        "momcrosslunge": "Cross Lunge",
        "momgirlpushups": "Girl Push Ups",
        
        "momlegrock": "Leg Pull Ins",
        "momopensquat": "Open Squat",
        "momstepdowns": "Step Downs",
        "momstraightcrunch": "Straight Leg Crunches",
        "momtoetouch": "Lying Down Toe Touch",
        "momsupermanarmraise": "Superman with Arm Raise",
        "momweightdrop": "Deadlifts",
        "momweightlift": "Extended Deadlifts",
        "momweightrock": "Reverse Curls"
        
    ]
    
    
    static let row3: [String] = [
        "fullplank", "leglift", "legraise", "plankarm", "plankraise", "mompushup", "manpushup", "mountainclimbers", "airbike"
    ]
    
    static let row4: [String] = [
        
        "ballmove", "ballwhirl", "burpee", "buttkickers", "ropepull"
    ]
    static let row5: [String] = [
        
        "stepover", "weightdrop", "weightlift", "weightrock"
    ]
    static let row6: [String] = [
        
        "momablift", "mombackballroll", "mombackleglift", "mombacklift", "mombackplankleglift", "momballroll", "momballsquat", "momcrossjump", "momcrosslunge", "momgirlpushups", "momlegrock", "momopensquat",  "momstepdowns", "momstraightcrunch", "momtoetouch", "momsupermanarmraise", "momweightdrop", "momweightlift", "momweightrock"
        
    ]
    
    init (featuredImage: UIImage!, description: String){
        
        
        self.featuredImage = featuredImage
        self.description = description
        
    }
    //MARK: Private
    
    static func createGifs3() -> [Tags]
    {
        var gifs: [Tags] = []
        for name in row3 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
    static func createGifs4() -> [Tags]
    {
        
        var gifs: [Tags] = []
        for name in row4 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
    static func createGifs5() -> [Tags]
    {
        
        var gifs: [Tags] = []
        for name in row5 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    static func createGifs6() -> [Tags]
    {
        
        var gifs: [Tags] = []
        for name in row6 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
}



