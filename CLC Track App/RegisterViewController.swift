//
//  RegisterViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 12/3/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
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
    }
}
