//
//  AddActivityViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 4/2/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit
import GooglePlaces

class AddActivityViewController: UIViewController {
    
    var list = ["Pune, India","Goa, India","Mumbai, India"]
    
    var timePicker = TimePickerDialogViewController()
    var MDTimePicker = MDTimePickerDialog()
    @IBOutlet weak var timetxtFld: UILabel!
    
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var desttxtFld: UITextField!
 //   @IBOutlet weak var timeTxtFld: UITextField!
    
    @IBOutlet weak var addTime: UIButton!
    @IBOutlet weak var timeeLbl: UILabel!
    @IBOutlet weak var remTime: UIButton!
    var ti = 0
    
    var str = ""
        
    @IBOutlet weak var notestxtFld: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet var addLocation: UIImageView!
    
    @IBOutlet weak var selectTime: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
         self.timeeLbl.text = String(0)
        
        let addLoctapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddActivityViewController.onLaunchClicked(sender:)))
        addLocation.isUserInteractionEnabled = true
        addLocation.addGestureRecognizer(addLoctapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.str = timePicker.getTime()
//        print("Swift got it :)",self.str as Any)
//        timeTxtFld.text = self.str
    }
    
    // Keyboard Hiding...
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddActivityViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
    @IBAction func timePicker(_ sender: Any) {
        
    //  timePicker.btnSelectTime(sender)
    //  sleep(5)
   //   DispatchQueue.main.async { self.str = self.timePicker.dateStr }
    //  DispatchQueue.main.async { self.str = self.timePicker.getTime() } // self.timePicker.getTime()
}
    
    @IBAction func adder(_ sender: Any) {
        
        self.ti = ti + 1
        self.timeeLbl.text = String(self.ti)
    }
    
    @IBAction func remover(_ sender: Any) {
        
        self.ti = ti - 1
        self.timeeLbl.text = String(self.ti)
    }
    
    //..End..
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddActivityViewController : MDTimePickerDialogDelegate {
    
    func timePickerDialog(_ timePickerDialog: MDTimePickerDialog, didSelectHour hour: Int, andMinute minute: Int) {
        self.timetxtFld.text = String(hour) + ":" + String(minute)
    }
    
    @IBAction func btnSelectedTime(_ sender: Any) {
        
        MDTimePicker.delegate = self
        MDTimePicker.show()
    }
}

extension AddActivityViewController : UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
     //   self.desttxtFld.text = self.list[row]
     //   self.cityPicker.isHidden = true
    }
}

//MARK: Google Places
extension AddActivityViewController : GMSAutocompleteViewControllerDelegate {
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func onLaunchClicked(sender: UIButton) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "NA")")
        self.desttxtFld.text =  place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}

extension AddActivityViewController : UIPickerViewDelegate {
    
}

extension AddActivityViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.desttxtFld {
            self.cityPicker.isHidden = false
            textField.endEditing(true)
        }
    }
}

