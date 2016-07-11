//
//  Gifs2CollectionViewCell.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/8/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit


class GifsCollectionViewCell: UICollectionViewCell  {
   
    
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var featuredImage:UIImageView!
    @IBOutlet weak var gifDescription:UILabel!

    
    let vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MoveScrollViewController") as! MoveScrollViewController)
    //var vc = MoveScrollViewController()
    //let vc = self.view.superview
    
    
    


    @IBAction func didSelectMove(sender: UIButton) {
        
        //self.delegate?.didSelectMove()
        
        if selectButton.selected == true{
            selectButton.selected = false
            //self.vc!.movesCount! -= 1
            //self.vc!.counterLabel.text = "\(self.vc!.movesCount)"
          
        }else{
            print("adding")
            selectButton.selected = true
            //vc.counterLabel.text = "\(vc.movesCount)"
            //print(vc.movesCount)
            //vc.movesCount += 1
            //print(movesCount)
            vc.updateCount()
        }
        
        }
    
    
    var gifs: Gifs! {
        didSet{
            updateUI()
        }
    }
    
    
    func updateUI(){
        
        featuredImage?.image! = gifs.featuredImage
        gifDescription?.text! = gifs.description
        
    }
    
}


class Gifs2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage2:UIImageView!
    @IBOutlet weak var gifDescription2:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var gifs2: Gifs2! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        if selectButton.selected == true{
            selectButton.selected = false
            
        }else{
            selectButton.selected = true
        }
        
        
    }
    
    
    
   func updateUI(){
        
        featuredImage2?.image! = gifs2.featuredImage2
        gifDescription2?.text! = gifs2.description2
        
    }
    
    
}


class Gifs3CollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var featuredImage3:UIImageView!
    @IBOutlet weak var gifDescription3:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var gifs3: Gifs3! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        if selectButton.selected == true{
            selectButton.selected = false
            
        }else{
            selectButton.selected = true
        }
        
        
    }
    
    
    
    private func updateUI(){
        
        featuredImage3?.image! = gifs3.featuredImage3
        gifDescription3?.text! = gifs3.description3
        
    }
}

class Gifs4CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage4:UIImageView!
    @IBOutlet weak var gifDescription4:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    
    var gifs4: Gifs4! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        if selectButton.selected == true{
            selectButton.selected = false
            
        }else{
            selectButton.selected = true
        }
        
        
    }
    
    private func updateUI(){
        
        featuredImage4?.image! = gifs4.featuredImage4
        gifDescription4?.text! = gifs4.description4
    }
}

class Gifs5CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage5:UIImageView!
    @IBOutlet weak var gifDescription5:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var gifs5: Gifs5! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        if selectButton.selected == true{
            selectButton.selected = false
            
        }else{
            selectButton.selected = true
        }
        
        
    }
    
    
    
    private func updateUI(){
        
        featuredImage5?.image! = gifs5.featuredImage5
        gifDescription5?.text! = gifs5.description5
    }
}


class Gifs6CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage6:UIImageView!
    @IBOutlet weak var gifDescription6:UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var gifs6: Gifs6! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didSelectMove(sender: UIButton) {
        
        if selectButton.selected == true{
            selectButton.selected = false
            
        }else{
            selectButton.selected = true
        }
        
        
    }
    
    
    
    private func updateUI(){
        
        featuredImage6?.image! = gifs6.featuredImage6
        gifDescription6?.text! = gifs6.description6
    }
}
