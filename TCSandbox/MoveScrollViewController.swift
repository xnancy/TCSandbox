//
//  MoveScrollExtensionViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/16/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit


protocol MoveScrollViewControllerDelegate {
    func incrementCount()
    func decrementCount()
    func incrementWorkoutCount()
    func decrementWorkoutCount()
    func incrementTagsCount()
    func decrementTagsCount()
    func updateTagView()
    func appendCompTag()
    func selectCollectionCell(index: Int, collectionView: Int)
    func updateView()
    func getCount() -> Int
}

class MoveScrollViewController: UIViewController, MoveScrollViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    //MARK: IB Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var collectionView4: UICollectionView!
    @IBOutlet weak var collectionView5: UICollectionView!
    @IBOutlet weak var collectionView6: UICollectionView!
    @IBOutlet weak var collectionView7: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewChallengeButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var tagForbidButton: UIButton!
   
    @IBOutlet weak var scrollButton: UIButton!
    
    private var gifs = Gifs.createGifs()
    private var gifs2 = Gifs.createGifs2()
    private var gifs3 = Tags.createGifs3()
    private var gifs4 = Tags.createGifs4()
    private var gifs5 = Tags.createGifs5()
    private var gifs6 = Tags.createGifs6()
    private var gifs7 = Gifs.createGifs7()
    
    private struct Storyboard {
        
        static let CellIndentifier = "GifCell"
        static let CellIndentifier2 = "GifCell2"
        static let CellIndentifier3 = "GifCell3"
        static let CellIndentifier4 = "GifCell4"
        static let CellIndentifier5 = "GifCell5"
        static let CellIndentifier6 = "GifCell6"
        static let CellIndentifier7 = "GifCell7"
        
    }
    
    var collection1Selected: [Bool] = []
    var collection2Selected: [Bool] = []
    var collection3Selected: [Bool] = []
    var collection4Selected: [Bool] = []
    var collection5Selected: [Bool] = []
    var collection6Selected: [Bool] = []
    var collection7Selected: [Bool] = []

    
    var movesCount: Int = 0
    var workoutCount: Int = 0
    var tagsCount: Int = 0
    var quickActionString: String!
    var quickActionString2: String!
    var compTags: [String] = []
    
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 2510
        updateView()
        //updateTagView()
        
        counterLabel.layer.cornerRadius = 16
        
        scrollButton.layer.cornerRadius = 0.5 * scrollButton.bounds.size.width
   
        collectionView6.delegate = self
        collectionView7.delegate = self
        // Do any additional setup after loading the view.
        
        collection1Selected = [
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false
        ]
        
        
        collection2Selected = [
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false
        ]
        
        
        collection3Selected = [
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false
        
        ]
        
        
        collection4Selected = [
            
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
        
        ]
        
        collection5Selected = [
            
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false
        
        ]
        
        collection6Selected = [
            
            false, false, false, false, false,
            false, false, false
        ]
    
        collection7Selected = [
           
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false, false, false,
            false, false, false
        ]
    }
    
    func selectCollectionCell(index: Int, collectionView: Int){
        if collectionView == 1 {
            collection1Selected[index] = !collection1Selected[index]
            collectionView1.reloadData()
        }else if collectionView == 2 {
            collection2Selected[index] = !collection2Selected[index]
            collectionView2.reloadData()
        }else if collectionView == 3 {
            collection3Selected[index] = !collection3Selected[index]
            collectionView3.reloadData()
        }else if collectionView == 4 {
            collection4Selected[index] = !collection4Selected[index]
            collectionView4.reloadData()
        }else if collectionView == 5 {
            collection5Selected[index] = !collection5Selected[index]
            collectionView5.reloadData()
        }else if collectionView == 6{
            collection6Selected[index] = !collection6Selected[index]
            collectionView6.reloadData()
        }else if collectionView == 7{
            collection7Selected[index] = !collection7Selected[index]
            collectionView7.reloadData()
        }

    }
    
    func incrementWorkoutCount() {
        workoutCount += 1
        updateView()
        updateTagView()
        //limitSelect()
        
    }
    
    func decrementWorkoutCount() {
        workoutCount -= 1
        updateView()
        updateTagView()
        //limitSelect()
    }
    
    
    func incrementCount() {
        movesCount += 1
        counterLabel.text = String(movesCount)
        
        //        self.viewDidLoad()
        updateView()
    }
    
    func decrementCount() {
        movesCount -= 1
        counterLabel.text = String(movesCount)
        //        self.viewDidLoad()
        
        updateView()
        
    }
    
    func incrementTagsCount() {
       tagsCount += 1
        counterLabel.text = String(movesCount)
        
        updateView()
    }
    
    func decrementTagsCount() {
        tagsCount -= 1
        counterLabel.text = String(movesCount)
        
        updateView()
        
    }
    
    func appendCompTag() {
        
        compTags.append("placeholder")
        
    }
    
    func updateView(){
        
        if workoutCount < 1 {
            viewChallengeButton.hidden = true
            scrollButton.hidden = true
            counterLabel.hidden = true
            
        }else{
            viewChallengeButton.hidden = false
            scrollButton.hidden = false
            counterLabel.hidden = false
        }
        
    }
    
    
    func updateTagView(){
        
        if workoutCount < 1 {
           tagForbidButton.hidden = false
            
        }else{
        tagForbidButton.hidden = true
        }
    }
    
    func getCount() -> Int {
        
        return movesCount
    }
    
    override func viewDidAppear(animated: Bool) {
               if( traitCollection.forceTouchCapability == .Available){
                registerForPreviewingWithDelegate(self, sourceView: collectionView1)
                registerForPreviewingWithDelegate(self, sourceView: view)
                //registerForPreviewingWithDelegate(self, sourceView: collectionView2)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let svc = segue.destinationViewController as! WorkoutEditorViewController
        svc.movesCount = movesCount
        svc.workoutCount = workoutCount
        svc.tagsCount = tagsCount
        svc.cTags = compTags
        //print(compTags)
        
        for (index, boolValue) in collection1Selected.enumerate(){
            if boolValue == true{
                svc.gifsToShow.append(Gifs.sortedRow1[index])
                
                
            }
        }
        
        for (index, boolValue) in collection2Selected.enumerate(){
            if boolValue == true{
                svc.gifsToShow.append(Gifs.sortedRow2[index])
                
            }
        }
        
        for (index, boolValue) in collection3Selected.enumerate(){
            if boolValue == true{
                svc.tagsToShow.append(Tags.sortedRow3[index])
                
            }
        }
        
        for (index, boolValue) in collection4Selected.enumerate(){
            if boolValue == true{
                svc.tagsToShow.append(Tags.sortedRow4[index])
                
            }
        }
        
        for (index, boolValue) in collection5Selected.enumerate(){
            if boolValue == true{
                svc.tagsToShow.append(Tags.sortedRow5[index])
                
            }
        }
        
        for (index, boolValue) in collection6Selected.enumerate(){
            if boolValue == true{
                svc.gifsToShow.append(Tags.sortedRow6[index])
                
            }
        }
        
        for (index, boolValue) in collection6Selected.enumerate(){
            if boolValue == true{
                svc.gifsToShow.append(Gifs.sortedRow7[index])
                
            }
        }
    }
    
    
    @IBAction func tagForbidAction(sender: UIButton) {
        let alertController = UIAlertController(title: "Cannot Add Tag", message:
            "Tags must be added to one (1) move", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func scrollToBottom(sender: AnyObject) {
        //var scrollViewHeight: CGFloat = scrollView.frame.size.height
        //let scrollContentSizeHeight: CGFloat = scrollView.contentSize.height
        
        let scrollOffset: CGFloat = scrollView.contentOffset.y
        if scrollOffset == 0 {
            scrollView.setContentOffset(CGPointMake(0, max(scrollView.contentSize.height - scrollView.bounds.size.height, 0) ), animated: true)
            scrollButton.selected = true
        }
        else {
            
            scrollView.setContentOffset(CGPointMake(0, min(scrollView.contentSize.height - scrollView.bounds.size.height, 0) ), animated: true)
            scrollButton.selected = false
        }
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView == collectionView1{
            return 1
        }else if collectionView == collectionView2{
            return 1
        }else if collectionView == collectionView3{
            return 1
        }else if collectionView == collectionView4{
            return 1
        }else if collectionView == collectionView5{
            return 1
        }else if collectionView == collectionView6{
            return 1
        }else{
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1{
            return gifs.count
        }else if collectionView == collectionView2{
            return gifs2.count
        }else if collectionView == collectionView3{
            return gifs3.count
        }else if collectionView == collectionView4{
            return gifs4.count
        }else if collectionView == collectionView5{
            return gifs5.count
        }else if collectionView == collectionView6{
            return gifs6.count
        }else{
            return gifs7.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1{
            
            let cell = collectionView1.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier, forIndexPath: indexPath) as! GifsCollectionViewCell
            cell.delegate = self
            cell.isSelected = collection1Selected[indexPath.row]
            cell.gifs = self.gifs[indexPath.item]
            cell.layer.cornerRadius = 2
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection1Selected[indexPath.row]
            return cell
        } else if collectionView == collectionView2{
            
            let cell = collectionView2.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier2, forIndexPath: indexPath) as! Gifs2CollectionViewCell
            cell.delegate = self
            cell.isSelected = collection2Selected[indexPath.row]
            cell.gifs2 = self.gifs2[indexPath.item]
            cell.layer.cornerRadius = 2
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection2Selected[indexPath.row]
            return cell
        } else if collectionView == collectionView3{
            
            let cell = collectionView3.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier3, forIndexPath: indexPath) as! Gifs3CollectionViewCell
            cell.delegate = self
            cell.isSelected = collection3Selected[indexPath.row]
            cell.gifs3 = self.gifs3[indexPath.item]
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection3Selected[indexPath.row]
            return cell
        } else if collectionView == collectionView4{
            
            let cell = collectionView4.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier4, forIndexPath: indexPath) as! Gifs4CollectionViewCell
            cell.delegate = self
            cell.isSelected = collection4Selected[indexPath.row]
            cell.gifs4 = self.gifs4[indexPath.item]
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection4Selected[indexPath.row]
            return cell
        } else if collectionView == collectionView5{
            let cell = collectionView5.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier5, forIndexPath: indexPath) as! Gifs5CollectionViewCell
            cell.delegate = self
            cell.isSelected = collection5Selected[indexPath.row]
            cell.gifs5 = self.gifs5[indexPath.item]
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection5Selected[indexPath.row]
            return cell
        } else if collectionView == collectionView6{
            let cell = collectionView6.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier6, forIndexPath: indexPath) as! Gifs6CollectionViewCell
            cell.delegate = self
            cell.isSelected = collection6Selected[indexPath.row]
            cell.gifs6 = self.gifs6[indexPath.item]
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection6Selected[indexPath.row]
            return cell
        } else {
            let cell = collectionView7.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier7, forIndexPath: indexPath) as! Gifs7CollectionViewCell
            cell.delegate = self
            cell.isSelected = collection7Selected[indexPath.row]
            cell.gifs7 = self.gifs7[indexPath.item]
            cell.layer.cornerRadius = 2
            cell.layer.masksToBounds = true
            cell.selectButton.selected = collection7Selected[indexPath.row]
            return cell
        }
    }
}


