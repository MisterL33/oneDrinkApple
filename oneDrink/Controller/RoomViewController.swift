import UIKit
import Firebase


var vSpinner : UIView?
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}




class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ref = Database.database().reference()
    var userId : String = ""
    var userTab = [String: Any?]()
    typealias FinishedDownload = () -> ()
    var users = [Any]()
    var count:UInt = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.collectionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chargeAllUser{
            self.collectionView.reloadData()
            self.removeSpinner()
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(self.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell

        let index = indexPath[1]
        
            
            var usersForCollection = self.users as! [[String: Any]]
            guard let userName = usersForCollection[index]["firstname"] else{
                return cell
            }
            guard let userAlcohol = usersForCollection[index]["favoriteAlcohol"] else{
                return cell
            }
            guard let userImgUrl = usersForCollection[index]["imageURL"] else{
                return cell
            }
            guard let url = URL(string: userImgUrl as! String) else{
                return cell
            }
            guard let dataImage = try? Data(contentsOf: url) else{
                return cell
            }
            cell.userName.text = userName as! String
            cell.userAlcohol.text = userAlcohol as! String
            cell.profileImage.image = UIImage(data: dataImage)
            
        
        return cell;
        
    }
    
    

    func chargeAllUser(completed: @escaping FinishedDownload){
        ref.child("users").observe(.value, with: { snapshot in
            
            self.count = snapshot.childrenCount
            var index = 0
            for user in snapshot.children.allObjects as! [DataSnapshot]{
                let user = user.value as? [String: AnyObject]
                self.users.append(user!)
                index += 1
                
            }
            completed()
        })
    }
}
