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
            Gifs(featuredImage: UIImage(named: "lifting")!, description: "Lifting"),
            //Gifs(featuredImage: UIImage(), featuredImage2: UIImage(named: "pushups"), description: "", description2: "Push Ups")
            
            
        ]
        
    }
    
}
