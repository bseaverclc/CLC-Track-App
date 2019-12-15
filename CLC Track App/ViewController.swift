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

    @IBOutlet weak var nameLabelOutlet: UILabel!
    
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var teambestsOutlet: UIButton!
    
    @IBOutlet weak var searchForAthleteOutlet: UIButton!
    
    @IBOutlet weak var scheduleOutlet: UIButton!
    
    @IBOutlet weak var meetInfoOutlet: UIButton!
    
    @IBOutlet weak var meetResultsOutlet: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        ref = Database.database().reference()
        print("In view will appear")
        if let currentUser = Auth.auth().currentUser?.uid{
        print(currentUser)
            ref = ref.child(currentUser)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                if let theUser = snapshot.value as? [String:String]{
                   self.nameLabelOutlet.text = "Welcome \(theUser["name"]!)"
                    print("Changing name")
                }
            }
            
                    
            
        }
        else{
            self.nameLabelOutlet.text = "Not logged in"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loading")
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
        
        
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
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Login", message: "Enter email and password", preferredStyle: .alert)
        
         alert.addTextField { (textfield) in
             textfield.placeholder = "email"
            
         }
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "password"
           
        }
         
         alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { [weak alert](_) in
            let email = alert!.textFields![0].text!
            let password = alert!.textFields![1].text!
        
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print("did not sign in")
                }
                else{
                    self.viewWillAppear(true)
                }
            }
    }))
    
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        do
        {
             try Auth.auth().signOut()
            self.viewWillAppear(true)
        }
        catch let error
        {
            print (error.localizedDescription)
        }
    }
    
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Admin Password", message: "Enter the Admin Password", preferredStyle: .alert)
       
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter Password"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert](_) in
            let textField = alert?.textFields![0]
            if textField!.text! == "pony"{
                self.performSegue(withIdentifier: "createSegue", sender: nil)
            }
        }))
         
        self.present(alert, animated: true, completion: nil)
        }
    
}

