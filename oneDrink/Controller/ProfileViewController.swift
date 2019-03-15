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
    let ref = Database.database().reference().root
    let storageRef = Storage.storage().reference()
    let firebaseUser = Auth.auth().currentUser
    var photoChanging = false;
    
    override func viewWillAppear(_ animated: Bool) {

        print("will appear")
        if firebaseUser != nil {

            ref.child("users").child(firebaseUser!.uid).observe(.value, with: { snapshot in
                if(snapshot.hasChild("lastname")){
                let value = snapshot.value as! NSDictionary
                let age:String = String(format: "%@", value["age"] as! CVarArg)
                self.favoriteAlcoholInput.text = value["favoriteAlcohol"] as? String ?? ""
                self.ageInput.text = age
                self.descriptionArea.text = value["description"] as? String ?? ""
                self.firstNameInput.text = value["firstname"] as? String ?? ""
                self.lastNameInput.text = value["lastname"] as? String ?? ""
                
                let genreFirebase = value["gender"] as? String ?? ""
                
                if(genreFirebase == "female"){
                    self.genderSwitch.setOn(true, animated: true)
                }
                    if(self.photoChanging == false){
                        self.photoUrl = URL(string: value["imageURL"] as? String ?? "")
                        let dataImage = try? Data(contentsOf: self.photoUrl!)
                        self.imageView.image = UIImage(data: dataImage!)
                    }
                
                }
                
            })
        }
    }
        
    
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
            let data = image.jpegData(compressionQuality: 0.3) as! NSData
            
            data.write(toFile: localPath!, atomically: true)
            photoChanging = true
            photoUrl = URL.init(fileURLWithPath: localPath!)
            
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveClick(_ sender: UIButton) {
        
        
        
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
            
            let userImagesRef = storageRef.child("users/" + firstName! + "-" + lastName! + ".jpeg");
            
            var strURL = ""
            
            print(photoUrl)
            if(self.photoChanging == true){
                userImagesRef.putFile(from: photoUrl, metadata: nil, completion: {(metadata, error) in
                    
                    userImagesRef.downloadURL(completion: { (url, error) in
                        if let urlText = url?.absoluteString {
                            
                            strURL = urlText
                            self.ref.child("users").child((self.firebaseUser?.uid)!).setValue(["age": self.user?.age, "gender": self.user?.gender, "firstname": self.user?.firstname, "lastname": self.user?.lastname, "description": self.user?.description, "favoriteAlcohol": self.user?.favoriteAlcohol, "imageURL": strURL])
                        }
                    })
                })
            }else{
                print("pas de changement photo")
                self.ref.child("users").child((self.firebaseUser?.uid)!).updateChildValues(["age": self.user?.age, "gender": self.user?.gender, "firstname": self.user?.firstname, "lastname": self.user?.lastname, "description": self.user?.description, "favoriteAlcohol": self.user?.favoriteAlcohol])
                
            }
            
            
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
