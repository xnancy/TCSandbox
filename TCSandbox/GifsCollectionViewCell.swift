//
//  Gifs2CollectionViewCell.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/8/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import SwiftyGif


class GifsCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var featuredImage:UIImageView!
    @IBOutlet weak var gifDescription:UILabel!
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    var isSelected:Bool! = false
    var delegate: MoveScrollViewControllerDelegate?
    var gifs: Gifs! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        
        
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementWorkoutCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 1)
            
            
        } else if delegate?.getCount() < 4 {
            self.delegate?.incrementCount()
            self.delegate?.incrementWorkoutCount()
            self.delegate?.appendCompTag()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 1)
            
            
        }
        
        
    }
    
    
    func updateUI(){
        
        featuredImage?.setGifImage(UIImage(gifName: gifs.featuredImage), manager: gifManager, loopCount: 200)
        gifDescription?.text! = gifs.description
        
    }
    
    
}


class Gifs2CollectionViewCell: UICollectionViewCell  {
    
    @IBOutlet weak var featuredImage2:UIImageView!
    @IBOutlet weak var gifDescription2:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var delegate: MoveScrollViewControllerDelegate?
    var isSelected:Bool! = false
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    var gifs2: Gifs! {
        didSet{
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        selectButton.selected = isSelected
    }
    
    
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementWorkoutCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 2)
            
        } else if delegate?.getCount() < 4 {
            self.delegate?.incrementCount()
            self.delegate?.incrementWorkoutCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 2)
        }
        
    }
    
    
    
    func updateUI(){
        
        featuredImage2?.setGifImage(UIImage(gifName: gifs2.featuredImage), manager: gifManager, loopCount: 200)
        gifDescription2?.text! = gifs2.description
        
    }
    
    
}

class Gifs7CollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var featuredImage7:UIImageView!
    @IBOutlet weak var gifDescription7:UILabel!
    var gifManager = SwiftyGifManager(memoryLimit: 50)
    var isSelected:Bool! = false
    var delegate: MoveScrollViewControllerDelegate?
    var gifs7: Gifs! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        
        
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementWorkoutCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 7)
            
            
        } else if delegate?.getCount() < 4 {
            self.delegate?.incrementCount()
            self.delegate?.incrementWorkoutCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 7)
            
            
        }
        
        
    }
    
    
    func updateUI(){
        
        featuredImage7?.setGifImage(UIImage(gifName: gifs7.featuredImage), manager: gifManager, loopCount: 200)
        gifDescription7?.text! = gifs7.description
        
    }
    
    
}




class Gifs3CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage3:UIImageView!
    @IBOutlet weak var gifDescription3:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var delegate: MoveScrollViewControllerDelegate?
    var isSelected:Bool! = false
    var gifs3: Tags! {
        didSet{
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        selectButton.selected = isSelected
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        
        
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 3)
        } else if delegate?.getCount() < 4 {
            self.delegate?.incrementCount()
            self.delegate?.incrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 3)
        }
    }
    
    private func updateUI(){
        
        featuredImage3?.image! = gifs3.featuredImage
        gifDescription3?.text! = gifs3.description
        
    }
    override func prepareForReuse() {
        selectButton.selected = isSelected
    }
    
}

class Gifs4CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage4:UIImageView!
    @IBOutlet weak var gifDescription4:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var delegate: MoveScrollViewControllerDelegate?
    var isSelected:Bool! = false
    var gifs4: Tags! {
        didSet{
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        selectButton.selected = isSelected
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        
        
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 4)
        } else if delegate?.getCount() < 4{
            self.delegate?.incrementCount()
            self.delegate?.incrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 4)
        }
    }
    
    private func updateUI(){
        
        featuredImage4?.image! = gifs4.featuredImage
        gifDescription4?.text! = gifs4.description
    }
    
    override func prepareForReuse() {
        selectButton.selected = isSelected
    }
}

class Gifs5CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage5:UIImageView!
    @IBOutlet weak var gifDescription5:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    var delegate: MoveScrollViewControllerDelegate?
    var isSelected:Bool! = false
    var gifs5: Tags! {
        didSet{
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        selectButton.selected = isSelected
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 5)
        } else if delegate?.getCount() < 4 {
            self.delegate?.incrementCount()
            self.delegate?.incrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 5)
        }
    }
    
    private func updateUI(){
        
        featuredImage5?.image! = gifs5.featuredImage
        gifDescription5?.text! = gifs5.description
    }
    
    override func prepareForReuse() {
        if isSelected == true{
            selectButton.selected = isSelected
        }else{
            selectButton.selected = false
            isSelected = false
        }
    }
}


class Gifs6CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage6:UIImageView!
    @IBOutlet weak var gifDescription6:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    var delegate: MoveScrollViewControllerDelegate?
    var isSelected:Bool! = false
    var gifs6: Tags! {
        didSet{
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        selectButton.selected = isSelected
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        let collectionView = self.superview as! UICollectionView
        let index = collectionView.indexPathForCell(self)
        
        
        if selectButton.selected == true {
            self.delegate?.decrementCount()
            self.delegate?.decrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 6)
        } else if delegate?.getCount() < 4 {
            self.delegate?.incrementCount()
            self.delegate?.incrementTagsCount()
            delegate?.selectCollectionCell((index?.row)!, collectionView: 6)
        }
        
    }
    
    
    private func updateUI(){
        
        featuredImage6?.image! = gifs6.featuredImage
        gifDescription6?.text! = gifs6.description
    }
    
    override func prepareForReuse() {
        selectButton.selected = isSelected
    }
}


