//
//  CollectionViewCell.swift
//  oneDrink
//
//  Created by code on 11/03/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userAlcohol: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    func displayContent(name: String, alcohol: String){
        userName.text = name
        userAlcohol.text = alcohol
    }
    
}
