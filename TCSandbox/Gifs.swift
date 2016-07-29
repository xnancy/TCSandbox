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
        "race2": "Race",
        "crawl": "Crawl",
        "popawheelie": "Pop a Wheelie",
        "ride": "Ride",
        "sleep": "Sleep",
        
        
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
        "singtocats": "I Needa One Dance...",
        "spidey": "Hangin' Around",
        "starwars": "You're Not My Dad",
        "supersanta": "Super Santa",
        "zuckBaby": "Zuck's Baby Makin' It Rain",
        "fantasticfour": "Fantastic Four",
        "lavarocket": "Lavarocket",
        "zombie": "Zombies",
        "xmasparty": "X-mas Party"
        
        
        
        
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
        "twerk", "rap", "poledance", "whip", "hotlineblingdance",
        "makeItRain", "race2", "crawl", "popawheelie", "ride",
        "sleep"
    ]
    
    static let sortedRow2 = row2.sort(<)
    
    
    static let row7: [String] = [
        
        "bikeparty", "chocolateDipped", "dibblebballwithhockeystick", "egg", "gadgets",
        "gingerbread", "interestingGif", "lowrider_gif1", "pacman", "pizzaproblems",
        "pokemonbowl", "pokemonhunter", "random", "reCat", "santamoPed",
        "simpsons", "singtocats", "spidey", "starwars", "supersanta",
        "zuckBaby", "pacman2", "untzuntz", "fantasticfour", "lavarocket",
        "zombie", "xmasparty"
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
        
        "bballcourt": "Basketball Court",
        "cafe": "Cafe",
        "college2": "College",
        "concert": "Concert",
        "car": "Car",
        "cornershop": "Market",
        "date": "Date",
        "dinner": "Dinner",
        "fastfoodplace": "Fast Food Place",
        "foodtruck": "Food Truck",
        "gym": "Gym",
        "forest": "Forest",
        "home": "Home",
        "kitchen": "Kitchen",
        "movies": "Movies",
        "office2": "Office",
        "park": "Park",
        "playground": "Playground",
        "pool2": "Pool",
        "restaurant1": "restaurant",
        "river": "River",
        "roof": "Roof",
        "school1": "School",
        "sf": "San Francisco",
        "street": "Street",
        "traffic": "Traffic",
        "work": "Work",
        "church": "Church",
        "party": "Party",
        

        "babybottle": "Baby Bottle",
        "bed": "Bed",
        "betterwaterbottle": "Water Bottle",
        "birthdaycake": "birthdaycake",
        "blender": "Blender",
        "boat": "Boat",
        "bucket": "bucket",
        "burger": "burger",
        "cat": "Cat",
        "chair": "Chair",
        "chicken": "Chicken",
        "clothes": "Clothes",
        "dog": "Dog",
        "dranks": "Dranks",
        "dryer": "Dryer",
        "espresso": "Espresso",
        "ferriswheel": "Ferris Wheel",
        "fruit": "Fruits",
        "glassofWater": "Water",
        "groceries": "Groceries",
        "hamster": "Hamster",
        "hand_sanitizer": "Hand Sanitizer",
        "hotdog": "Hot Dog",
        "icecream": "Ice Cream",
        "kite": "Kite",
        "markers": "Markers",
        "phone": "Phone",
        "pigeonWalking": "Pigeon",
        "pokemongo": "Pokeball",
        "pot": "Pot",
        "skates": "Skates",
        "soda": "Soda",
        "coffee": "Coffee",
        "trashcans": "Trashcan",
        "supersoaker": "Super Soaker",
        "table": "Table",
        "toaster": "Toaster",
        "turtle": "Turtle",
        "toiletpaper2": "Toilet Paper",
        "whitevans": "White Vans",
        "tree": "Tree",
        "tv_stand": "TV",
        "vacuum": "Vacuum",
        "writingUtensils": "Writing Utensils",
        "xboxcontroller": "Gaming Controller",
        "hat": "Hat",
        "laptop": "Laptop",
        "money": "Money",
        "plunger": "Plunger",
        "tissue": "Tissue",
        "toilet": "Toilet",
        "balloon": "Balloon",
        "beachball": "Beachball",
        "chipsanddips": "Chips and Dip",
        
        "abe": "Abraham Lincoln",
        "bestfriend": "Best Friend",
        "bff": "BFF",
        "brother": "Brother",
        "bfgf": "Boyfriend/Girlfriend",
        "chewie": "Chewie",
        "damnDaniel": "Daaaaamn Daaaniel",
        "family": "Family",
        "famousperson": "Famous Person",
        "grandmagrandpa": "Grandma/Grandpa",
        "jose": "Jose",
        "savannah": "Savannah",
        "nancy": "Nancy",
        "sasha": "Sasha",
        "shaq": "Shaq",
        "mark": "Zuck",
        "sister1": "Sister",
        "storeclerk": "Store Clerk",
        "stranger": "Stranger",
        "teacher": "Teacher",
        
        "blindfolded": "While Blindfolded",
        "eyesclosed": "With Eyes Closed",
        "handsbehindback": "With Hands Behind Back",
        "oneFoot": "While Balancing On One Foot",
        "onehand": "With One Hand",
        "toeStand": "Toe Stand",
        "withChopsticks": "With Chopsticks",
        "withsomeoneonyourback": "While Carrying Someone"
        
        
    ]
    
    
    static let row3: [String] = [
        "bballcourt", "cafe", "college2", "concert", "car",
        "cornershop", "date", "dinner", "fastfoodplace", "foodtruck",
        "gym", "forest", "home", "kitchen", "movies",
        "office2", "park", "playground", "pool2", "restaurant1",
        "river", "roof", "school1", "sf", "street",
        "traffic", "work", "church", "party"
    ]
    
    static let sortedRow3 = row3.sort(<)
    
    

    
    static let row4: [String] = [
        
        "babybottle", "bed", "betterwaterbottle", "birthdaycake", "blender",
        "boat", "bucket", "burger", "cat", "chair",
        "chicken", "clothes", "dog", "dranks", "dryer",
        "espresso", "ferriswheel", "fruit", "glassofWater", "groceries",
        "hamster", "hand_sanitizer", "hotdog", "icecream", "kite",
        "markers", "phone", "pigeonWalking", "pokemongo", "pot",
        "skates", "soda", "coffee", "trashcans", "supersoaker",
        "table", "toaster", "turtle", "toiletpaper2", "whitevans",
        "tree", "tv_stand", "vacuum", "writingUtensils", "xboxcontroller",
        "hat", "laptop", "money", "plunger", "tissue",
        "toilet", "balloon", "beachball", "chipsanddips"
    ]
    
    static let sortedRow4 = row4.sort(<)
    
    
    
    
    
    static let row5: [String] = [
        
        "bestfriend", "bff", "brother", "bfgf", "chewie",
        "damnDaniel", "family", "famousperson", "grandmagrandpa", "jose",
        "savannah", "nancy", "sasha", "shaq", "sister1",
        "storeclerk", "stranger", "teacher", "mark", "abe"
    ]
    
    static let sortedRow5 = row5.sort(<)
    
    
    
    
    
    static let row6: [String] = [
        
        "blindfolded", "eyesclosed", "handsbehindback", "oneFoot", "onehand",
        "toeStand", "withChopsticks", "withsomeoneonyourback"
        
    ]
    
    static let sortedRow6 = row6.sort(<)
    
    
    
    init (featuredImage: UIImage!, description: String){
        
        
        self.featuredImage = featuredImage
        self.description = description
        
    }
    //MARK: Private
    
    static func createGifs3() -> [Tags]
    {
        var gifs: [Tags] = []
        for name in sortedRow3 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
    static func createGifs4() -> [Tags]
    {
        
        var gifs: [Tags] = []
        for name in sortedRow4 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
    static func createGifs5() -> [Tags]
    {
        
        var gifs: [Tags] = []
        for name in sortedRow5 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    static func createGifs6() -> [Tags]
    {
        
        var gifs: [Tags] = []
        for name in sortedRow6 {
            let new = Tags(featuredImage: UIImage(named: name)!, description: tagDictionary[name]!)
            gifs.append(new)
        }
        return gifs
    }
    
}



