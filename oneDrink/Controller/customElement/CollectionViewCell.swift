import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userAlcohol: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
