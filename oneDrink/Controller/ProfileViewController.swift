//
//  ProfileViewController.swift
//  oneDrink
//
//  Created by Developer on 28/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var descriptionArea: UITextView!
    @IBOutlet weak var favoriteAlcoholInput: UITextField!
    
    var user : User?
    var imagePicker = UIImagePickerController()
    
    @IBAction func chooseClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else  { return }
        imageView.image = image
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveClick(_ sender: UIButton) {
        if lastNameInput.text != "" &&
           firstNameInput.text != "" &&
           ageInput.text != "" &&
           favoriteAlcoholInput.text != ""{
            
//                self.user = User(picture: <#Data?#>, age: <#Int#>, gender: <#String#>, firstname: <#String#>, lastname: <#String#>, description: <#String#>, favoriteAlcohol: <#String#>)
            
        } else{
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
