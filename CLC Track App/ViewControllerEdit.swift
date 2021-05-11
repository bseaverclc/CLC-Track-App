//
//  ViewControllerEdit.swift
//  CLC Track App
//
//  Created by Tiger Coder on 4/8/21.
//  Copyright © 2021 clc.seaver. All rights reserved.
//

import UIKit
import Firebase
class ViewControllerEdit: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
   var row2 = 0
    var row1 = 0
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var backColorPicker: UIPickerView!
    
    var pickedImage = UIImage()
    
    var pickerDataBackColor: [[String]] = [[String]]()
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerDataBackColor[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataBackColor[component][row])
        print("Component:   \(component)   Row:  \(row) ")
        if (component == 0) {
            row1 = row
        }
        else {
            row2 = row
        }
    }
    
 
    

  
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.backColorPicker.delegate = self
        self.backColorPicker.dataSource = self
       
        pickerDataBackColor = [["Black", "Red", "Blue", "Green", "Yellow","Purple"],["Orange","Pink","White","Red","Blue","Green"]]
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
     
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
         self.pickedImage = info[.originalImage] as! UIImage
         self.imageViewOutlet.image = self.pickedImage
            //self.saveImageToFirebase(image: pickedImage!)
        }
}

    @IBAction func uploadPicAction(_ sender: UIButton) {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    

    
    @IBAction func saveButtonAction(_ sender: Any) {
        switch row1{
        case 0 :
            print(pickerDataBackColor[0][row1])
        case 1 :
            print(pickerDataBackColor[0][row1])
        case 2 :
            print(pickerDataBackColor[0][row1])
        case 3 :
            print(pickerDataBackColor[0][row1])
        case 4 :
            print(pickerDataBackColor[0][row1])
        case 5 :
            print(pickerDataBackColor[0][row1])
        default:
            print(pickerDataBackColor[0][row1])
        }
        switch row2 {
        case 0:
            print(pickerDataBackColor[1][row2])
        case 1:
            print(pickerDataBackColor[1][row2])
        case 2:
            print(pickerDataBackColor[1][row2])
        case 3:
            print(pickerDataBackColor[1][row2])
        case 4:
            print(pickerDataBackColor[1][row1])
        case 5:
            print(pickerDataBackColor[1][row2])
        default:
            print(pickerDataBackColor[1][row2])
        }
    
    
         
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if #available(iOS 13.0, *) {
            if segue.destination is AthleteViewController {
                let vc = segue.destination as? AthleteViewController
                vc?.backGroundColor = UIColor.red
            }
        } else {
            // Fallback on earlier versions
        }
    }
      
}
    
   
    

