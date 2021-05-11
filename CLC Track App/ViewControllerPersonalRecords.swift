//
//  ViewControllerPersonalRecords.swift
//  CLC Track App
//
//  Created by Tiger Coder on 4/29/21.
//  Copyright © 2021 clc.seaver. All rights reserved.
//

import UIKit

class ViewControllerPersonalRecords: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate {

   
    @IBOutlet weak var eventPickerOutlet: UIPickerView!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var events = ["Events"]
    let defaults = UserDefaults.standard
    var pickerDataEvent: [[String]] = [[String]]()
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 19
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return (pickerDataEvent[component][row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      //  print(pickerDataEvent[component][row])
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        
        self.eventPickerOutlet.delegate = self
        self.eventPickerOutlet.dataSource = self
        
        events = ["100 M Dash","200 M Dash","400 M Dash","800 M Run", "1600 M Run", "3200 M Run", "100 M Hurdles", "110 M Hurdles","300 M Hurdles", "4x100 M relay", "4x200 M relay","4x400 M relay", "4x800 M relay", "Shotput", "Discus","Triple Jump", "Long Jump","High Jump", "Pole Vault"]
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cell1")!
        cell.textLabel!.text = events[indexPath.row]
        //cell.detailTextLabel?.text = ""
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
