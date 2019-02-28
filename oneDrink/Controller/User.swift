//
//  User.swift
//  oneDrink
//
//  Created by Developer on 28/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var picture: Data?
    var age: Int
    var gender: String
    var firstname: String
    var lastname: String
    var description: String
    var favoriteAlcohol: String
    
    var image: UIImage? {
        
        if let data = picture {
            return UIImage(data: data)
        }
        
        return nil
    }
}
