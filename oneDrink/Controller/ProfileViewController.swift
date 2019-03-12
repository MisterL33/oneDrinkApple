//
//  ProfileViewController.swift
//  oneDrink
//
//  Created by Developer on 28/02/2019.
//  Copyright © 2019 code. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var favoriteAlcoholInput: UITextField!
    @IBOutlet weak var descriptionArea: UITextField!
    
    
    @IBOutlet weak var urlInput: UILabel!
    
    var user : User?
    var imagePicker = UIImagePickerController()
    var photoUrl : URL!
    
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
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            
            photoUrl = URL.init(fileURLWithPath: localPath!)
            
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveClick(_ sender: UIButton) {
        let ref = Database.database().reference().root
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images");
        if lastNameInput.text != "" &&
           firstNameInput.text != "" &&
           ageInput.text != "" &&
           favoriteAlcoholInput.text != ""{
        
            let image = imageView.image
            let picture = image!.pngData()
            let age = Int(ageInput.text ?? "18")
            var gender = ""
            if !genderSwitch.isOn{
                gender = "male"
            }else{
                gender = "female"
            }
            let firstName = firstNameInput.text
            let lastName = lastNameInput.text
            let description = descriptionArea.text
            let favoriteAlcohol = favoriteAlcoholInput.text
            self.user = User(picture: picture, age: age!, gender: gender, firstname: firstName!, lastname: lastName!, description: description!, favoriteAlcohol: favoriteAlcohol!)
            
            let userImagesRef = storageRef.child("user/profil.png");
            var downloadURL : URL!
            let base64String = picture?.base64EncodedString(options: .lineLength64Characters)
            let uploadTask = userImagesRef.putFile(from: photoUrl, metadata: nil) { metadata, error in
                
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print("Failed to download url:", error!)
                        return
                    } else {
                        print(url)
                    }
                    
                })
            
            }

            let userFromFirebase = Auth.auth().currentUser
            print(downloadURL)
            
            ref.child("users").child((userFromFirebase?.uid)!).setValue(["age": user?.age, "gender": user?.gender, "firstname": user?.firstname, "lastname": user?.lastname, "description": user?.description, "favoriteAlcohol": user?.favoriteAlcohol, "imageURL": downloadURL])
            
            

            
        } else{
            print("certain champs sont vide")
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
