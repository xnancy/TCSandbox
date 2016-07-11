import Foundation
import UIKit

class Gifs
{
    
    var featuredImage: UIImage!
    
    var description = ""
    
    
    init (featuredImage: UIImage!, description: String){
        
        
        self.featuredImage = featuredImage
        self.description = description
        
    }
    
    //MARK: Private
    
    static func createGifs() -> [Gifs]
    {
        
        return [
            Gifs(featuredImage: UIImage(named: "jump rope")!, description: "Jump Rope"),
            Gifs(featuredImage: UIImage(named: "boxing")!, description: "Boxing"),
            Gifs(featuredImage: UIImage(named: "running")!, description: "Running"),
            Gifs(featuredImage: UIImage(named: "lifting")!, description: "Lifting")
        ]
        
    }
    
}

class Gifs2
{
    
    var featuredImage2: UIImage!
    
    var description2 = ""
    
    
    init (featuredImage2: UIImage!, description2: String){
        
        
        self.featuredImage2 = featuredImage2
        self.description2 = description2
        
    }
    
    //MARK: Private
    
    static func createGifs2() -> [Gifs2]
    {
        
        return [
            Gifs2(featuredImage2: UIImage(named: "pushups")!, description2: "Push Ups"),
            Gifs2(featuredImage2: UIImage(named: "pullup")!, description2: "Pull Ups"),
            Gifs2(featuredImage2: UIImage(named: "wallsit")!, description2: "Wall Sit"),
            Gifs2(featuredImage2: UIImage(named: "hipairplane")!, description2: "Hip Airplane"),
            Gifs2(featuredImage2: UIImage(named: "windshieldwipers")!, description2: "Windshield Wipers"),
            Gifs2(featuredImage2: UIImage(named: "stepups")!, description2: "Step Ups"),
            Gifs2(featuredImage2: UIImage(named: "jumpingjacks")!, description2: "Jumping Jacks")
        ]
        
    }
    
}

class Gifs3
{
    
    var featuredImage3: UIImage!
    
    var description3 = ""
    
    
    init (featuredImage3: UIImage!, description3: String){
        
        
        self.featuredImage3 = featuredImage3
        self.description3 = description3
        
    }
    
    //MARK: Private
    
    static func createGifs3() -> [Gifs3]
    {
        
        return [
            Gifs3(featuredImage3: UIImage(named: "fullplank")!, description3: "Superman"),
            Gifs3(featuredImage3: UIImage(named: "leglift")!, description3: "Lying Down Leg Raises"),
            Gifs3(featuredImage3: UIImage(named: "legraise")!, description3: "Seated Leg Pull Ins"),
            Gifs3(featuredImage3: UIImage(named: "plankarm")!, description3: "Plank With Arm Raise"),
            Gifs3(featuredImage3: UIImage(named: "plankraise")!, description3: "T Plank With Twist"),
            Gifs3(featuredImage3: UIImage(named: "mompushup")!, description3: "Elevated Push Ups"),
            Gifs3(featuredImage3: UIImage(named: "manpushup")!, description3: "Elevated Plank"),
            Gifs3(featuredImage3: UIImage(named: "mountainclimbers")!, description3: "Mountain Climbers"),
            Gifs3(featuredImage3: UIImage(named: "airbike")!, description3: "Airbike")
        ]
        
    }
    
}

class Gifs4
{
    
    var featuredImage4: UIImage!
    
    var description4 = ""
    
    
    init (featuredImage4: UIImage!, description4: String){
        
        
        self.featuredImage4 = featuredImage4
        self.description4 = description4
        
    }
    
    //MARK: Private
    
    static func createGifs4() -> [Gifs4]
    {
        
        return [
            Gifs4(featuredImage4: UIImage(named: "ballmove")!, description4: "Forward Lunge with Twist"),
            Gifs4(featuredImage4: UIImage(named: "ballwhirl")!, description4: "Big Arm Circles"),
            Gifs4(featuredImage4: UIImage(named: "burpee")!, description4: "Plank Pull Ins"),
            Gifs4(featuredImage4: UIImage(named: "buttkickers")!, description4: "Buttkickers"),
            Gifs4(featuredImage4: UIImage(named: "ropepull")!, description4: "Standing Row")
            
        ]
        
    }
    
}

class Gifs5
{
    
    var featuredImage5: UIImage!
    
    var description5 = ""
    
    
    init (featuredImage5: UIImage!, description5: String){
        
        
        self.featuredImage5 = featuredImage5
        self.description5 = description5
        
    }
    
    //MARK: Private
    
    static func createGifs5() -> [Gifs5]
    {
        
        return [
            Gifs5(featuredImage5: UIImage(named: "stepover")!, description5: "Side to Side Hops"),
            Gifs5(featuredImage5: UIImage(named: "weightdrop")!, description5: "Romanian Deadlift"),
            Gifs5(featuredImage5: UIImage(named: "weightlift")!, description5: "Reverse Lunge with Overhead Press"),
            Gifs5(featuredImage5: UIImage(named: "weightrock")!, description5: "Plie Squat with V Raise")
            
        ]
        
    }
    
}

class Gifs6
{
    
    var featuredImage6: UIImage!
    
    var description6 = ""
    
    
    init (featuredImage6: UIImage!, description6: String){
        
        
        self.featuredImage6 = featuredImage6
        self.description6 = description6
        
    }
    
    //MARK: Private
    
    static func createGifs6() -> [Gifs6]
    {
        
        return [
            Gifs6(featuredImage6: UIImage(named: "momablift")!, description6: "Ab Lift with Extended Leg"),
            Gifs6(featuredImage6: UIImage(named: "mombackballroll")!, description6: "Backward Ball Roll"),
            Gifs6(featuredImage6: UIImage(named: "mombackleglift")!, description6: "Backward Leg Lift"),
            Gifs6(featuredImage6: UIImage(named: "mombacklift")!, description6: "Reverse Elevated Push Ups"),
            Gifs6(featuredImage6: UIImage(named: "mombackplankleglift")!, description6: "Reverse Plank Leg Lift"),
            Gifs6(featuredImage6: UIImage(named: "momballroll")!, description6: "Forward Ball Roll"),
            Gifs6(featuredImage6: UIImage(named: "momballsquat")!, description6: "Ball Squat"),
            Gifs6(featuredImage6: UIImage(named: "momcrossjump")!, description6: "Cross Jump"),
            Gifs6(featuredImage6: UIImage(named: "momcrosslunge")!, description6: "Cross Lunge"),
            Gifs6(featuredImage6: UIImage(named: "momgirlpushups")!, description6: "Girl Push Ups"),
            Gifs6(featuredImage6: UIImage(named: "momlegrock")!, description6: "Leg Pull Ins"),
            Gifs6(featuredImage6: UIImage(named: "momopensquat")!, description6: "Open Squat"),
            Gifs6(featuredImage6: UIImage(named: "momstepdowns")!, description6: "Step Downs"),
            Gifs6(featuredImage6: UIImage(named: "momstraightcrunch")!, description6: "Straight Leg Crunches"),
            Gifs6(featuredImage6: UIImage(named: "momsupermanarmraise")!, description6: "Superman with Arm Raise"),
            Gifs6(featuredImage6: UIImage(named: "momtoetouch")!, description6: "Lying Down Toe Touch"),
            Gifs6(featuredImage6: UIImage(named: "momweightdrop")!, description6: "Deadlifts"),
            Gifs6(featuredImage6: UIImage(named: "momweightlift")!, description6: "Extended Deadlifts"),
            Gifs6(featuredImage6: UIImage(named: "momweightrock")!, description6: "Reverse Curls"),
            
        ]
        
    }
    
}




