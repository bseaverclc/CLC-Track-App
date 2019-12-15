//
//  AthleteViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 11/29/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

import UIKit
import Firebase

class AthleteViewController: UIViewController {

    var ref: DatabaseReference!
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    var athlete: Athlete!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        
        imageViewOutlet.image = athlete.pic
        textViewOutlet.text = "Name: \(athlete.name)\nYear: \(athlete.year)\nUID: \(athlete.uid)"
        
        if let currentUser = Auth.auth().currentUser?.uid{
            if athlete.uid == currentUser{
                print("this is the current user")
            textViewOutlet.isEditable = true
            }
        }
 
        // Do any additional setup after loading the view.
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
