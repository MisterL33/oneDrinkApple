import UIKit
import Firebase

class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ref : DatabaseReference!
    var userId : String = ""
    var userTab = [String: Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chargeAllUser()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell

        ref = Database.database().reference()
        ref.child("users").observe(.value, with: { snapshot in
            
            for userId in snapshot.children.allObjects as! [DataSnapshot]{
                let user = userId.value as? [String: AnyObject]
                let userName = user?["firstname"]
                let userAlcohol = user?["favoriteAlcohol"]
                let userImgUrl = user?["imageURL"]
                
                let url = URL(string: userImgUrl as! String)
                let dataImage = try? Data(contentsOf: url!)
                cell.userName.text = userName as! String
                cell.userAlcohol.text = userAlcohol as! String
                cell.profileImage.image = UIImage(data: dataImage!)
                
                print(userName!)
                
            }
        })
        return cell;
        
    }

    func chargeAllUser() {
        
    }
}
