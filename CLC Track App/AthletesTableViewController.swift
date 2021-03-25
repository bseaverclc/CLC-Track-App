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
    var uid: String
    var info: String
    
    
}

class CustomTableViewCell: UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        self.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
    }
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
        
        var profileImage = UIImage(named: "camden")
       if let dictionary = snapshot.value as? NSDictionary{
        guard let urlString = dictionary["profileImageUrl"] as? String
            else{
                print("profileurl not found")
                return
                }
        guard let url = URL(string: urlString) else
        {print("url not created")
            return}
        let dowloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                    print(error?.localizedDescription)
                    print("error with dataTask")
                }
                else{
            // This is extremely slow to happen
                    // Takes up to 1 minute to load pictures
                // How do we speed this up?
                DispatchQueue.main.async {
                    profileImage = UIImage(data: data!)
                     print("profile Image changed")
                    var theName = dictionary["name"] as! String
                    var theYear = Int(dictionary["year"] as! String)!
                    var theUid = dictionary["uid"] as! String
                    var theInfo = dictionary["info"] as! String
                    self.athletes.append(Athlete(name: theName, year: theYear, pic: profileImage!, uid: theUid, info: theInfo))
                    self.tableView.reloadData()
                }
                }
            }
        // Calling the URLSession download task
        // It doesn't automatically get called on its own
        dowloadTask.resume()
        
                  
      
    /* Moved this up to Dispatch Queue to make it happen after the images are loaded
     var theName = dictionary["name"] as! String
        var theYear = Int(dictionary["year"] as! String)!
        self.athletes.append(Athlete(name: theName, year: theYear, pic: profileImage!))
 */
            
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
        let cell  = (tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath))

        
        // Configure the cell...
        cell.textLabel?.text = athletes[indexPath.row].name
        cell.detailTextLabel?.text = String(athletes[indexPath.row].year)
        
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width)!/2.0
        cell.imageView?.layer.borderWidth = 3.0
        cell.imageView?.clipsToBounds = true
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
