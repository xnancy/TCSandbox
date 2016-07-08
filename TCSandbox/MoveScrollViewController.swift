import UIKit

class MoveScrollViewController: UIViewController {
    
    
    //MARK: IB Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var gifs = Gifs.createGifs()
    
    
    //MARK:
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
    
    
    
    @IBAction func cancelAction(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
}

private struct Storyboard {
    
    static let CellIndentifier = "GifCell"
    
}


extension MoveScrollViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier, forIndexPath: indexPath) as! GifsCollectionViewCell
        
        
        cell.gifs = self.gifs[indexPath.item]
        
        return cell
    }
    
}
