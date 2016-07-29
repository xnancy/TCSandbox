//
//  RatingViewController.swift
//  PopupDialog
//
//  Created by Martin Wildfeuer on 11.07.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import PopupDialog

class RatingViewController: UIViewController {
    
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textLabel4: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var secMinLabel: UILabel!
    
    @IBOutlet weak var colorImageView1: UIImageView!
    @IBOutlet weak var colorImageView2: UIImageView!
    @IBOutlet weak var colorImageView3: UIImageView!
    @IBOutlet weak var colorImageView4: UIImageView!
    
    
    
    //@IBOutlet weak var cosmosStarRating: CosmosView!
    
    var text: String!
    var timeLimit: Int = 0
    var gifnames: [String] = []
    var tagnames: [String] = []
    var delegate: WorkoutEditorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel1.text = Gifs.gifDictionary[gifnames[0]]
        
        
        if timeLimit < 60 {
            timeLabel.text = String(timeLimit)
            secMinLabel.text = "seconds"
        }else{
            secMinLabel.text = "min"
        }
        
        if timeLimit == 60{
            timeLabel.text = "1:00"
        }
        if timeLimit == 75{
             timeLabel.text = "1:15"
        }
        if timeLimit == 90{
             timeLabel.text = "1:30"
        }
        if timeLimit == 105{
             timeLabel.text = "1:45"
        }
        if timeLimit == 120{
            timeLabel.text = "2:00"
        }
        
    
        if gifnames.count > 1 {
            
            if gifnames.count == 2 {
                textLabel2.text = Gifs.gifDictionary[gifnames[1]]
                
            }
            
            if gifnames.count == 3 {
                textLabel2.text = Gifs.gifDictionary[gifnames[1]]
                textLabel3.text = Gifs.gifDictionary[gifnames[2]]
                
            }
            
            if gifnames.count == 4 {
                
                textLabel2.text = Gifs.gifDictionary[gifnames[1]]
    
                textLabel3.text = Gifs.gifDictionary[gifnames[2]]
                
                textLabel4.text = Gifs.gifDictionary[gifnames[3]]
                }
            
            
        }
        
        
        
        if tagnames.count > 0 {
            
            if gifnames.count == 1 {
                textLabel2.text = Tags.tagDictionary[tagnames[0]]
                
                
                if tagnames.count == 2 {
                    textLabel3.text = Tags.tagDictionary[tagnames[1]]
                                    }
                    
                else if tagnames.count == 3{
                    textLabel3.text = Tags.tagDictionary[tagnames[1]]
                    
                    textLabel4.text = Tags.tagDictionary[tagnames[2]]
                    
                }
                
                
            }
            else if gifnames.count == 2 {
                textLabel3.text = Tags.tagDictionary[tagnames[0]]
               
                
                if tagnames.count == 2{
                    textLabel4.text = Tags.tagDictionary[tagnames[1]]
                    
                }
                
            }
            else if gifnames.count == 3 {
                
                textLabel4.text = Tags.tagDictionary[tagnames[0]]
               
            }
            
        }

     
        if gifnames.count + tagnames.count == 1{
            
            textLabel2.hidden = true
            textLabel3.hidden = true
            textLabel4.hidden = true
            colorImageView2.hidden = true
            colorImageView3.hidden = true
            colorImageView4.hidden = true

        }else if gifnames.count + tagnames.count == 2{
            
        
            textLabel3.hidden = true
            textLabel4.hidden = true
            colorImageView3.hidden = true
            colorImageView4.hidden = true
            
        }else if gifnames.count + tagnames.count == 3{
        
            
            textLabel4.hidden = true
            colorImageView4.hidden = true
            
            
            
        }
        
        

        // Do any additional setup after loading the view.
    }

  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
