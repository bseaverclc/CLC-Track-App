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
                   let pickedImage = info[.originalImage] as? UIImage
                   self.imageViewOutlet.image = pickedImage
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
                    print(uid)
                   
                    
                    
                }
            }
        }
        
        if let currentUser = Auth.auth().currentUser?.uid {
            let ath = ["name": self.firstOutlet.text!,
            "year": self.yearOutlet.text!
             ]
        ref.child(currentUser).setValue(ath)
            
            
                                
            
                //adding the artist inside the generated unique key
           // self.ref.child(key).setValue(ath)
    }
}
}
