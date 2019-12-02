//
//  AthletesTableViewController.swift
//  CLC Track App
//
//  Created by Brian Seaver on 11/28/19.
//  Copyright © 2019 clc.seaver. All rights reserved.
//

import UIKit
import Firebase

struct Athlete {
    var name: String
    var year: Int
    var pic: UIImage
    
    
}


class AthletesTableViewController: UITableViewController {
var ref: DatabaseReference!
    var athletes = [Athlete]()
    var selected: Athlete!
    
   
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
    /*ref.child("athletes").observeSingleEvent(of: .value) { (snapshot) in
        print(snapshot)
 */
        ref.observe(.childAdded){ snapshot in
            
            print(snapshot)
        
        
       if let dictionary = snapshot.value as? NSDictionary{
    var theName = dictionary["name"] as! String
        var theYear = Int(dictionary["year"] as! String)!
        self.athletes.append(Athlete(name: theName, year: theYear, pic: UIImage(named: "camden")!))
            
           // self.athletes.append(Athlete(name: "Ryan Atkinson", year: 11, pic: UIImage(named: "teamPic")!))
        // need to reload the data because the closure happens on a different thread
        self.tableView.reloadData()
        }
        
        
        }
    
        
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(athletes.count)
        return athletes.count
    }

    //This gets called for every row in the tableviewe
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        
        // Configure the cell...
        cell.textLabel?.text = athletes[indexPath.row].name
        cell.detailTextLabel?.text = String(athletes[indexPath.row].year)
        
        cell.imageView?.image = athletes[indexPath.row].pic
        
        /*
        let key = ref.childByAutoId().key!
             
             //creating artist with the given values
             let ath = ["name": athletes[indexPath.row].name,
                             "year": athletes[indexPath.row].year as! String
                             ]
         
             //adding the artist inside the generated unique key
             ref.child(key).setValue(ath)
 */
        
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selected = athletes[indexPath.row]
    performSegue(withIdentifier: "toAthlete", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! AthleteViewController
        nvc.athlete = selected
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
