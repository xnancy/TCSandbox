//
//  ChallengeSentViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/26/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SwiftyGif

class ChallengeSentViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.gifImageView.setGifImage(UIImage(gifName: "done"), manager: self.gifManager, loopCount: 1)
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
