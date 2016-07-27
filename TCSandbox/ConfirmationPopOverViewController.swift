//
//  ConfirmationPopOverViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/22/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

class ConfirmationPopOverViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel1: UILabel!
    @IBOutlet weak var middleLabel2: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    var gifCount: Int = 0
    var tagCount: Int = 0
    var delegate: WorkoutEditorDelegate?
    var gifsNames: [String] = []
    var tagNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        middleLabel1.text = Gifs.gifDictionary[(gifsNames[0])]
//    
//
//        if gifCount > 1 {
//            
//            if gifCount == 2 {
//                middleLabel2.text = Gifs.gifDictionary[(gifsNames[1])]
//            }
//            
//            if gifCount == 3 {
//                middleLabel2.text = Gifs.gifDictionary[(gifsNames[1])]
//                topLabel.text = Gifs.gifDictionary[(gifsNames[2])]
//                
//            }
//            
//            if gifCount == 4 {
//                middleLabel2.text = Gifs.gifDictionary[(gifsNames[1])]
//                topLabel.text = Gifs.gifDictionary[(gifsNames[2])]
//                bottomLabel.text = Gifs.gifDictionary[(gifsNames[3])]
//                            }
//        }
//        
//        
//        if tagCount > 0 {
//            
//            if gifCount == 1 {
//                middleLabel2.text = Tags.tagDictionary[tagNames[0]]
//                
//                if tagCount == 2 {
//                    bottomLabel.text = Tags.tagDictionary[tagNames[1]]
//                }
//                    
//                else if tagCount == 3{
//                    topLabel.text = Tags.tagDictionary[tagNames[1]]
//                    bottomLabel.text = Tags.tagDictionary[tagNames[2]]
//                }
//                
//            }
//            else if gifCount == 2 {
//                bottomLabel.text = Tags.tagDictionary[tagNames[0]]
//                
//                if tagCount == 2{
//                    topLabel.text = Tags.tagDictionary[tagNames[1]]
//                }
//                
//            }
//            else if gifCount == 3 {
//                bottomLabel.text = Tags.tagDictionary[tagNames[0]]
//            }
//            
//        }
    
   // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
