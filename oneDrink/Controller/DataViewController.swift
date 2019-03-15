//
//  DataViewController.swift
//  oneDrink
//
//  Created by code on 01/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit
import Firebase

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var dataObject: String = ""


    @IBAction func registerPressed(_ sender: Any) {
        
        let ref = Database.database().reference().root
        try! Auth.auth().signOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logButton.layer.cornerRadius = 25
        registerButton.layer.cornerRadius = 25
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }


}

