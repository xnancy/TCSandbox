import UIKit

class GifsCollectionViewCell: UICollectionViewCell {
    
    var gifs: Gifs! {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var featuredImage:UIImageView!
    @IBOutlet weak var gifDescription:UILabel!
    
    
    
    private func updateUI(){
        
        featuredImage?.image! = gifs.featuredImage
        gifDescription?.text! = gifs.description
        
    }
    
}