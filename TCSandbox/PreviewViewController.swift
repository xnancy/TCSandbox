//
//  PreviewViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/16/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SwiftyGif

class PreviewViewController: UIViewController {

    
    @IBOutlet weak var selectedGifImageView: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    
    var selectedItem: String?
    var selectedItem2: String?
    var delegate: MoveScrollViewControllerDelegate?
    var gifmanager = SwiftyGifManager(memoryLimit: 20)
    
    var previewActions: [UIPreviewActionItem]{
        
        
        let item1 = UIPreviewAction(title: "5x", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
           self.delegate?.incrementPeekAndPopCount()
            //print(self.delegate?.peekAndPopCount)
        }
        
        let item2 = UIPreviewAction(title: "10x", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            
        }
        
        let item3 = UIPreviewAction(title: "20x", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            
        }
        
        let item4 = UIPreviewAction(title: "More Reps Than Me", style: .Default) { (action:UIPreviewAction, vc: UIViewController) -> Void in
            
         }
              
        return [item1, item2, item3, item4]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedItem)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        textLabel.text = Gifs.gifDictionary[selectedItem!]
        selectedGifImageView.setGifImage(UIImage(gifName: selectedItem!), manager: gifmanager, loopCount: 20)
        
    
    }
    
    override func viewDidDisappear(animated: Bool) {
    
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
