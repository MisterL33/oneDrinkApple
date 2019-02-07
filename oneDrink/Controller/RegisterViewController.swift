//
//  RegisterViewController.swift
//  oneDrink
//
//  Created by code on 07/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountAction(_ sender: AnyObject) {
        
        Auth.auth().createUser(withEmail: loginTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("register success")
                self.performSegue(withIdentifier: "registerGoHome", sender: self)
            }
            
        }
    }

}