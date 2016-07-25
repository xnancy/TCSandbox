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
    weak var moveScrollViewController: MoveScrollViewController?
    
    
    var selectedItem: String?
    var selectedItem2: String?
    var delegate: MoveScrollViewControllerDelegate?
    var indexx: Int!
    var gifmanager = SwiftyGifManager(memoryLimit: 20)
    var movesCount: Int!
    
    var previewActions: [UIPreviewActionItem]{
        
        let item1 = UIPreviewAction(title: "5x", style: .Default) { (previewAction, viewController) in
          
            if self.movesCount < 4 {
            
                if let msvc = self.moveScrollViewController {
                    msvc.compTags.append("5X")
                    self.delegate?.incrementCount()
                    self.delegate?.incrementWorkoutCount()
                    self.delegate?.selectCollectionCell((self.indexx)!, collectionView: 1)
                
                }
            }
        }
        
        let item2 = UIPreviewAction(title: "10x", style: .Default){ (previewAction, viewController) in
            
            if self.movesCount < 4 {
                
                if let msvc = self.moveScrollViewController {
                    msvc.compTags.append("10X")
                    self.delegate?.incrementCount()
                    self.delegate?.incrementWorkoutCount()
                    self.delegate?.selectCollectionCell((self.indexx)!, collectionView: 1)
                    
                }
            }
        }
        
        let item3 = UIPreviewAction(title: "20x", style: .Default) { (previewAction, viewController) in
            
            if self.movesCount < 4 {
                
                if let msvc = self.moveScrollViewController {
                    msvc.compTags.append("20X")
                    self.delegate?.incrementCount()
                    self.delegate?.incrementWorkoutCount()
                    self.delegate?.selectCollectionCell((self.indexx)!, collectionView: 1)
                    
                }
            }
        }
        
        let item4 = UIPreviewAction(title: "More Than Me", style: .Default) { (previewAction, viewController) in
            
            if self.movesCount < 4 {
                
                if let msvc = self.moveScrollViewController {
                    msvc.compTags.append("MTM")
                    self.delegate?.incrementCount()
                    self.delegate?.incrementWorkoutCount()
                    self.delegate?.selectCollectionCell((self.indexx)!, collectionView: 1)
                    
                }
            }
        }
        return [item1, item2, item3, item4]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        textLabel.text = Gifs.gifDictionary[selectedItem!]
        selectedGifImageView.setGifImage(UIImage(gifName: selectedItem!), manager: gifmanager, loopCount: 200)
        
    
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
