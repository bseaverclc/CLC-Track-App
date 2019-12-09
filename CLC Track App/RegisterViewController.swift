//
//  RegisterViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 12/3/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
  @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var firstOutlet: UITextField!
    @IBOutlet weak var lastOutlet: UITextField!
    @IBOutlet weak var yearOutlet: UITextField!
    @IBOutlet weak var eventOutlet: UITextField!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    var ref : DatabaseReference!
    
    var pickedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePicAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
                   imagePicker.sourceType = UIImagePickerController.SourceType.camera
               }
               else{
                   imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
               }
               present(imagePicker, animated: true, completion: nil)
           }
           
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               picker.dismiss(animated: true){
                self.pickedImage = info[.originalImage] as! UIImage
                self.imageViewOutlet.image = self.pickedImage
                   //self.saveImageToFirebase(image: pickedImage!)
               }
    }
    
    
    @IBAction func uploadPicAction(_ sender: UIButton) {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailOutlet.text!, password: passwordOutlet.text!) { (result, error) in
            if error != nil{
                print(error?.localizedDescription)
            }
            else{
                if let uid = result?.user.uid{
                    //print(uid)
                    let ath = ["name": self.firstOutlet.text!,
                        "year": self.yearOutlet.text!
                         ]
                    self.ref.child(uid).setValue(ath)
                    self.saveImageToFirebase(image: self.pickedImage)
                        print(uid)
                    Auth.auth().updateCurrentUser(result!.user, completion: nil)
                    print("Current User \(Auth.auth().currentUser?.uid)")
                }
            }
        }
        
      
}
    
    func saveImageToFirebase(image: UIImage){
        print("Saving image to firebase")
        if let currentUser = Auth.auth().currentUser?.uid{
                   
            let storageRef = Storage.storage().reference().child("profileImages").child(currentUser)
            if storageRef != nil{
                   
            guard let imageData = image.pngData() else {
                print("pngData not good")
                return}
                   
            let storeData = storageRef.putData(imageData)
            }
            else{
                print("Storage Ref was nil")
            }
    }
        else{
            print("current Id not valid")
        }
    }
}

