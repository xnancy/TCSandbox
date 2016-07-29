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
