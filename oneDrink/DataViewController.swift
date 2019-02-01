//
//  DataViewController.swift
//  oneDrink
//
//  Created by code on 01/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        logButton.layer.cornerRadius = 25
        registerButton.layer.cornerRadius = 25
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }


}

