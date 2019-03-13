//
//  RoomViewController.swift
//  oneDrink
//
//  Created by code on 11/03/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let url = URL(string: "https://www.wikichat.fr/wp-content/uploads/sites/2/comment-soigner-une-plaie-dun-chat.jpg")
        let dataImage = try? Data(contentsOf: url!)
        
        cell.userName.text = "romain"
        cell.userAlcohol.text = "Rhum"
        cell.profileImage.image = UIImage(data: dataImage!)
        return cell;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
