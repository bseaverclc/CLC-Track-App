//
//  ViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 11/28/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

// Camera steps
/*
 1)  info.plist Privacy
 2)  Add delegates to class header
 3)  Create an object of UIImagePickerController class
 4)  In viewDidLoad make delegate of UIImagePickerController = self
 5)  Create buttons and actions for photo and camera
 6)  Create a UIImageView and make an outlet for it
 7)  Write code for both buttons(look below)
 
 */

import UIKit
import SafariServices

import Firebase


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
var ref: DatabaseReference!
  let imagePicker = UIImagePickerController()

    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBOutlet weak var yearOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loading")
        imagePicker.delegate = self
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    @IBAction func addAthleteAction(_ sender: UIButton) {
        let key = ref.child("athletes").childByAutoId().key
            
            //creating artist with the given values
        let ath = ["name": nameOutlet.text!,
                   "year": yearOutlet.text!
                    ]
                            
        
            //adding the artist inside the generated unique key
            ref.child(key!).setValue(ath)
    }
    @IBAction func meetResultsAction(_ sender: UIButton) {
           let url = URL(string: "https://www.athletic.net/TrackAndField/School.aspx?SchoolID=16275")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func scheduleAction(_ sender: UIButton) {
        let url = URL(string: "https://clchs.rschoolteams.com/page/2932")
              let svc = SFSafariViewController(url: url!)
              present(svc, animated: true, completion: nil)
    }
    
    
    @IBAction func teamBestsAction(_ sender: UIButton) {
        let url = URL(string: "https://www.athletic.net/TrackAndField/EventRecords.aspx?SchoolID=16275&S=2019")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
   
    
    @IBAction func meetInfoAction(_ sender: UIButton) {
        let url = URL(string: "https://drive.google.com/drive/u/0/folders/1FpqDxiFD0SpVNPUXhijZZMlDTrf8okZg")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
        
    }
    
    @IBAction func pictureAction(_ sender: UIButton) {
        
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
            self.imageOutlet.image = pickedImage
            self.saveImageToFirebase(image: pickedImage!)
        }
        
        
    }
    
    func saveImageToFirebase(image: UIImage){
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
    
    @IBAction func registerButton(_ sender: UIButton) {
        
       
            
        }
    
}

