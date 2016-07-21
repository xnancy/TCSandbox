//
//  Preview2ViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/17/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SwiftyGif

class Preview2ViewController: UIViewController {

    @IBOutlet weak var selectedGifImageView: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    var selectedItem2: String?
    var gifmanager = SwiftyGifManager(memoryLimit: 20)
    var delegate: MoveScrollViewControllerDelegate?
    var previewActions: [UIPreviewActionItem]{
        
        
        let item1 = UIPreviewAction(title: "LTM", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            self.delegate?.incrementPeekAndPopCount()
            //print(self.delegate?.peekAndPopCount)
        }
        
        let item2 = UIPreviewAction(title: "FTM", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            
        }
        
        let item3 = UIPreviewAction(title: "HTM", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            
        }
        
        let item4 = UIPreviewAction(title: "BTM", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            
        }
        
        return [item1, item2, item3, item4]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = Gifs.gifDictionary[selectedItem2!]
        selectedGifImageView.setGifImage(UIImage(gifName: selectedItem2!), manager: gifmanager, loopCount: 20)
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
