//
//  RescueViewController.swift
//  oneDrink
//
//  Created by Developer on 07/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit
import Firebase

class RescueViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var rescueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func rescueButtonPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: loginTextField.text!, completion: { (error) in
            if let error = error{
                print(error)
            }else{
                print("email sent")
                self.performSegue(withIdentifier: "backtoLogSegue", sender: self)
            }
        })
    }
    
}
