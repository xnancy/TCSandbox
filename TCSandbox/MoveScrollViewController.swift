import UIKit

protocol delegate {
    var movesCount: Int { get set }
}

class MoveScrollViewController: UIViewController {
    

    //MARK: IB Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var collectionView4: UICollectionView!
    @IBOutlet weak var collectionView5: UICollectionView!
    @IBOutlet weak var collectionView6: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var counterLabel: UILabel!
    
    
    private var gifs = Gifs.createGifs()
    private var gifs2 = Gifs2.createGifs2()
    private var gifs3 = Gifs3.createGifs3()
    private var gifs4 = Gifs4.createGifs4()
    private var gifs5 = Gifs5.createGifs5()
    private var gifs6 = Gifs6.createGifs6()
    
    
    //var movesCount: Int = 0
    //var delegate: GifsCollectionViewCell?
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 1750
        //print(movesCount)
        //print(counterLabel)
        
        
        
        //self.counterLabel.text = "\(self.movesCount)"
        updateCount()
        //counterLabel! = giffy.counterLabel
        //print(giffy.counterLabel)
        // Do any additional setup after loading the view.
    }
    
    
    func updateCount(){
       // dispatch_async(dispatch_get_main_queue()) {
            print("called")
            
         //self.counterLabel.text = "\(self.movesCount)"
            //print(self.movesCount)
            //self.updateCount()
            
        
        //}
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
    
    
    
    /*@IBAction func cancelAction(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }*/
    
    
    
}

private struct Storyboard {
    
    static let CellIndentifier = "GifCell"
    static let CellIndentifier2 = "GifCell2"
    static let CellIndentifier3 = "GifCell3"
    static let CellIndentifier4 = "GifCell4"
    static let CellIndentifier5 = "GifCell5"
    static let CellIndentifier6 = "GifCell6"
    
}


extension MoveScrollViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    
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
        }else{
            return gifs6.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1{
            
            let cell = collectionView1.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier, forIndexPath: indexPath) as! GifsCollectionViewCell
        
                cell.gifs = self.gifs[indexPath.item]
        
            return cell} else if collectionView == collectionView2{
            
            let cell = collectionView2.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier2, forIndexPath: indexPath) as! Gifs2CollectionViewCell
               
               cell.gifs2 = self.gifs2[indexPath.item]
    
            return cell} else if collectionView == collectionView3{
        
            let cell = collectionView3.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier3, forIndexPath: indexPath) as! Gifs3CollectionViewCell
            
            cell.gifs3 = self.gifs3[indexPath.item]
            
            return cell} else if collectionView == collectionView4{
            
            let cell = collectionView4.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier4, forIndexPath: indexPath) as! Gifs4CollectionViewCell
            
            cell.gifs4 = self.gifs4[indexPath.item]
            
            return cell} else if collectionView == collectionView5{
            
            let cell = collectionView5.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier5, forIndexPath: indexPath) as! Gifs5CollectionViewCell
            
            cell.gifs5 = self.gifs5[indexPath.item]
            
            return cell} else {
            
            let cell = collectionView6.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier6, forIndexPath: indexPath) as! Gifs6CollectionViewCell
            
            cell.gifs6 = self.gifs6[indexPath.item]

            return cell}
        }
    }
