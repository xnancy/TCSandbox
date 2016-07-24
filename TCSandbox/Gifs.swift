import Foundation
import UIKit
import SwiftyGif


class Gifs
{
    // var imageName: String!
    
    var featuredImage: String!
    var description = ""
    
    static let gifDictionary: [String: String] = [
        
        "untzuntz": "Untz Untz Untz",
        "whip": "Whip Dance",
        "skiprope": "Skip Rope",
        "hipairplane": "Hip Airplane",
        "pushups": "Push Ups",
        "wallsit": "Wall Sit",
        "airbike": "Airbike",
        "bigarmcircles": "Big Arm Circles",
        "buttkickers": "Butt Kickers",
        "elevatedpushups": "Elevated Push Ups",
        "forwardlunge": "Forward Lunge",
        "boxing": "Boxing",
        "pullups": "Pull Ups",
        "running": "Run",
        "leglifts": "Leg Lifts",
        "manpushups": "Elevated Push Ups",
        "mountainclimbers": "Mountain Climbers",
        "plankarmraise": "Plank Arm Raise",
        "plankpullin": "Plank Pull Ins",
        "pliesquat": "Plie Squat",
        "reverselunge": "Reverse Lunge",
        "windshieldwipers": "Windshield Wipers",
        "stepups": "Step Ups",
        "romaniandeadlift": "Romanian Deadlift",
        "seatedlegpullins": "Seated Leg Pullins",
        "jumpingjacks": "Jumping Jacks",
        "standingrow": "Standing Row",
        "stepovers": "Side to Side Hops",
        "superman": "Superman",
        "tplankwithtwist": "T-Plank with Twists",
        "squats": "Squats",
        "stretch": "Stretch",
        "spin1": "Spin",
        "sideleglifts": "Side Leg Lifts",
        "jog": "Jogging",
        "cycle" : "Cycle",
        "crunches": "Crunches",
        "dumbbells": "Dumb Bells",
        "jumprope1" : "Jump Rope",
        "chinups": "Chin Ups",
        "chairdip": "Chair Dips",
        "deadlift": "Dead Lift",
        "bench": "Bench Press",
        "intensesquats": "Intense Deadlifts",
        "forwardlean": "Foward Squats",
        "kickers": "Kickers",
        "sittingrow": "Sitting Row",
        "pulldowns": "Pull Downs",
        
        
        
        
        
        
        
        "catch": "Catch",
        "cheer": "Cheer",
        "chug": "Chug",
        "dive": "Dive",
        "robot": "Robot Dance",
        "eating": "Eat",
        "elvisdance": "Elvis Dance",
        "kick": "Kick",
        "fight": "Fight",
        "dribble": "Dribble",
        "fistpump": "Fist Pump",
        "boxkangaroo" : "Box",
        "flip": "Flip",
        "flipOver": "Flip Over",
        "freeThrow": "Make a Freethrow",
        "haduken": "Hadouken",
        "hammerdance": "Hammer Dance",
        "highFive": "High Five",
        "juggle":"Juggle",
        "jump": "Jump",
        "kiss": "Kiss",
        "makeItRain": "Make It Rain",
        "dunk": "Dunk",
        "crossover": "Cross Over",
        "punch": "Punch",
        "ridebike": "Ride Bike",
        "rockOut": "Rock Out",
        "rockoutHardCore": "Rock Out Hardcore",
        "makebasket": "Make a Basket",
        "singMinion": "Sing",
        "sit": "Sit",
        "skate": "Skate",
        "spin": "Spin",
        "spinBball": "Spin Basketball",
        "swing2": "Swing",
        "tackle": "Tackle",
        "takeapicture": "Take a Picture",
        "takeselfie": "Take a Selfie",
        "throw1": "Throw",
        "walkcool": "Walk Cool",
        "bellydance": "Belly Dance",
        "discodance": "Disco Dance",
        "moonwalker": "Moonwalk",
        "jakedance": "Jake Dance",
        "hotlineblingdance": "Hotline Bling Dance",
        "dancebattle": "Dance Battle",
        "carltondance": "Carlton Dance",
        "runningman": "Running Man Dance",
        "twerk": "Twerk",
        "rap": "Rap",
        "breakdance": "Break Dance",
        "poledance": "Pole Dance",
        
        
        
        "bikeparty": "Bike Party",
        "chocolateDipped" : "Epic Swirly",
        "dibblebballwithhockeystick": "Epic!",
        "egg": "Sunnyside Up",
        "gadgets": "Eternal",
        "gingerbread": "Chillaxin",
        "interestingGif": "Domino Effect",
        "lowrider_gif1": "Low Low",
        "pacman": "Trick or Treat",
        "pacman2": "Impossible to Win",
        "pizzaproblems": "Pizza Problems",
        "pokemonbowl": "Gotta Hit Em' All",
        "pokemonhunter": "Pokemon Hunter",
        "random": "When Ball is Life",
        "reCat": "catcatcatcatcatcat",
        "santamoPed": "Gnarly Claus",
        "simpsons": "Stretch",
        "singtocats": "I Needa one dance...",
        "spidey": "Hangin' Around",
        "starwars": "You're Not My Dad",
        "supersanta": "Super Santa",
        "zuckBaby": "Zuck's Baby Makin' It Rain"
        
        
        
    ]
    
    static let row1: [String] = [
       
        "hipairplane", "pushups", "pullups", "wallsit", "windshieldwipers",
        "stepups", "jumpingjacks","running", "reverselunge", "plankpullin",
        "forwardlunge", "leglifts", "manpushups", "mountainclimbers",
        "plankarmraise", "pliesquat", "romaniandeadlift","standingrow", "stepovers",
        "seatedlegpullins", "superman", "tplankwithtwist", "squats", "stretch",
        "spin1", "sideleglifts","jog", "cycle", "crunches",
        "dumbbells", "jumprope1", "chinups", "chairdip", "deadlift",
        "elevatedpushups", "intensesquats", "forwardlean", "sittingrow", "pulldowns"
   
    ]
    
    static let sortedRow1 = row1.sort(<)
    
    static let row2: [String] = [
        
        "catch", "cheer","chug", "dive", "robot",
        "eating", "elvisdance", "kick", "fight", "fistpump",
        "flip", "flipOver", "freeThrow", "haduken", "hammerdance",
        "highFive", "juggle", "jump", "kiss", "dunk","skiprope",
        "crossover", "punch", "ridebike", "rockOut", "rockoutHardCore",
        "makebasket", "singMinion", "sit","skate", "spin",
        "spinBball", "swing2", "tackle", "takeapicture", "takeselfie",
        "throw1", "walkcool", "dribble", "bellydance", "discodance",
        "moonwalker", "jakedance", "dancebattle", "carltondance", "runningman",
        "twerk", "rap", "poledance", "whip", "hotlineblingdance"
    ]
    
    static let sortedRow2 = row2.sort(<)
    
    
    static let row7: [String] = [
        
        "bikeparty", "chocolateDipped", "dibblebballwithhockeystick", "egg", "gadgets",
        "gingerbread", "interestingGif", "lowrider_gif1", "pacman", "pizzaproblems",
        "pokemonbowl", "pokemonhunter", "random", "reCat", "santamoPed",
        "simpsons", "singtocats", "spidey", "starwars", "supersanta",
        "zuckBaby", "pacman2", "untzuntz"
    ]
    
    static let sortedRow7 = row7.sort(<)
    
    
    init (featuredImage: String, description: String){
        
        
        self.featuredImage = featuredImage
        self.description = description
        
    }
    
    //MARK: Private
    
    static func createGifs() -> [Gifs]
    { 
        var gifs: [Gifs] = []

        for name in sortedRow1 {
            let new = Gifs(featuredImage: name, description: gifDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    static func createGifs2() -> [Gifs]
    {
        var gifs: [Gifs] = []
        for name in sortedRow2 {
            let new = Gifs(featuredImage: name, description: gifDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
    
    static func createGifs7() -> [Gifs]
    {
        var gifs: [Gifs] = []
        for name in sortedRow7 {
            let new = Gifs(featuredImage: name, description: gifDictionary[name]!)
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
        
        "ballmove", "ballwhirl", "burpee", "ropepull"
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



