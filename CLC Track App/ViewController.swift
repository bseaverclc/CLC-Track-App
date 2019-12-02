//
//  ViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 11/28/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

class ViewController: UIViewController {
var ref: DatabaseReference!
    
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBOutlet weak var yearOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

