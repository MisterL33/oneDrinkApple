//
//  LoginViewController.swift
//  oneDrink
//
//  Created by code on 07/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginConfirmButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        //self.performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
}
