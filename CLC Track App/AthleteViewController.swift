//
//  AthleteViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 11/29/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

import UIKit
import Firebase
import SafariServices

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AthleteViewController: UIViewController {

    var ref: DatabaseReference!
    @IBOutlet var athleticNetButton: UIView!
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    var athlete: Athlete!
    
    @objc func adjustForKeyboard(notification: Notification)
    {
        // 1
        let userInfo = notification.userInfo!
         
        // 2
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            view.frame.origin.y = -1.0*keyboardViewEndFrame.height
        // 3
        /*
        if notification.name == UIResponder.keyboardWillHideNotification {
            textViewOutlet.contentInset = UIEdgeInsets.zero
        } else {
           textViewOutlet.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        textViewOutlet.scrollIndicatorInsets = textViewOutlet.contentInset
            
        // 4
        let selectedRange = textViewOutlet.selectedRange
        textViewOutlet.scrollRangeToVisible(selectedRange)
        */
    }
    var backGroundColor = UIColor.systemBackground
    var textColor = UIColor.orange
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backGroundColor = self.view.backgroundColor!
         textColor = textViewOutlet.backgroundColor!
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        ref = Database.database().reference()
    
    
        
        imageViewOutlet.image = athlete.pic
        textViewOutlet.text = athlete.info
    }
        
        
        
 
        // Do any additional setup after loading the view.
    
    
    @IBAction func editAction(_ sender: UIButton) {
        let alert =  UIAlertController(title: "Denied Access", message: "You don't have edit rights", preferredStyle: .alert)
        let action =  UIAlertAction(title: "OK", style: .default, handler: nil)
         alert.addAction(action)
        if let currentUser = Auth.auth().currentUser?.uid{
        if athlete.uid == currentUser{
            print("this is the current user")
        textViewOutlet.isEditable = true
            textViewOutlet.becomeFirstResponder()
        }
        else{
            present(alert, animated: true, completion: nil)
            }
        }
        else{
           
            present(alert, animated: true, completion: nil)
        }
        }
        
    
    @IBAction func saveAction(_ sender: UIButton) {
        athlete.info = textViewOutlet.text
        textViewOutlet.resignFirstResponder()
        view.frame.origin.y = 0;
         textViewOutlet.isEditable = false
        if let currentUser = Auth.auth().currentUser{ self.ref.child(currentUser.uid).child("info").setValue(textViewOutlet.text)
        }
        
    }
    
    @IBAction func athleticNetButtonAction(_ sender: UIButton) {
        let url = URL(string: "https://www.athletic.net/")
     let svc = SFSafariViewController(url: url!)
     present(svc, animated: true, completion: nil)
     }
    
}
