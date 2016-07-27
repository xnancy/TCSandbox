//
//  RatingViewController.swift
//  PopupDialog
//
//  Created by Martin Wildfeuer on 11.07.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!

    //@IBOutlet weak var cosmosStarRating: CosmosView!
   
    var text: String!
    var pop: Int = 0
    var delegate: WorkoutEditorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = String(pop)
        print(pop)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
