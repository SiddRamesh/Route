//
//  ProfileViewController.swift
//  Ramesh Siddanavar
//
//  Created by Ramesh Siddanavar on 3/22/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
   
    @IBOutlet var upperView: UIView!
  
    @IBOutlet var profileImageUpload: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var statePickerValue: UITextField!
   
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var pickerCountryValue: UITextField!
    @IBOutlet var pickerCountryButton: UIButton!
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var submitButton: UIButton!
    
    var typePickerView: UIPickerView = UIPickerView()
    
    var hiddingOperation = false
    var statePickerAction = false
    
    let pickerRowTitles = ["first ","second ","third ", "fourth "];
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.typePickerView.dataSource = self;
        self.typePickerView.delegate = self;
        
        self.typePickerView.alpha = 0
        self.typePickerView.backgroundColor = UIColor.white
        self.typePickerView.frame = CGRect.init(x: self.statePickerValue.frame.origin.x,
                                                y: self.statePickerValue.frame.origin.y + self.statePickerValue.frame.size.height + 8,
                                            width: self.view.frame.size.width - 80,
                                           height: 200)
        
        self.upperView.addSubview(typePickerView)
      
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
       
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
      
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ProfileViewController.imageTapped(img:)))
        profileImageUpload.isUserInteractionEnabled = true
        profileImageUpload.addGestureRecognizer(tapGestureRecognizer)
      
        let ViewtapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(endEiting))
        upperView.isUserInteractionEnabled = true
        upperView.addGestureRecognizer(ViewtapGestureRecognizer)
    }
    // MARK:  override picker methods
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return pickerRowTitles.count;
    }
    
    @nonobjc func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerRowTitles[row]
    }
    
    @nonobjc func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView.frame.origin.y < self.pickerCountryValue.frame.origin.y){
            
            statePickerAction = true
            self.statePickerValue.text = pickerRowTitles[row]
            
        }else{
            statePickerAction = false
            self.pickerCountryValue.text = pickerRowTitles[row]
        }
        self.showAndHidePicker()
    }
    
    @objc func imageTapped(img: AnyObject)
    {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Upload", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("upload")
        })
        let saveAction = UIAlertAction(title: "Take Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("take photo")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }

    @objc func endEiting() {
        
        self.upperView.endEditing(true)
    }
    
    // MARK:  show state picker
    
    @IBAction func showPicker(sender: AnyObject) {
        
        self.typePickerView.frame = CGRect.init(x: self.statePickerValue.frame.origin.x,
                                                y: self.statePickerValue.frame.origin.y + self.statePickerValue.frame.size.height + 8,
                                            width: self.view.frame.size.width - 80,
                                            height: 200)
        statePickerAction = true
        self.showAndHidePicker()
        
    }

    @IBAction func countryPickAction(sender: AnyObject) {
        
        statePickerAction = false
        self.typePickerView.frame = CGRect.init(x: self.statePickerValue.frame.origin.x,
                                                y: self.statePickerValue.frame.origin.y + self.statePickerValue.frame.size.height + 8,
                                            width: self.view.frame.size.width - 80,
                                            height: 200)
        
        self.showAndHidePicker()
    }
    
    // MARK:  override text keyboard func
    @nonobjc func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        
        textField.resignFirstResponder()
        return false
    }
  
    @IBAction func submitChanges(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Success", message: "changed updated", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion:nil)
    }
    
    // MARK:  show and hide picker
    func showAndHidePicker(){
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            if (!self.hiddingOperation){
                
                if(self.statePickerAction){
                    
                    self.countryLabel.frame.origin.y = self.countryLabel.frame.origin.y+self.typePickerView.frame.size.height + 8
                    self.pickerCountryValue.frame.origin.y = self.pickerCountryValue.frame.origin.y+self.typePickerView.frame.size.height + 8
                    self.pickerCountryButton.frame.origin.y = self.pickerCountryButton.frame.origin.y+self.typePickerView.frame.size.height + 8
                    self.submitButton.frame.origin.y = self.submitButton.frame.origin.y+self.typePickerView.frame.size.height + 8
                    
                }else{
                    
                    self.submitButton.frame.origin.y = self.submitButton.frame.origin.y+self.typePickerView.frame.size.height + 8
                }
                
            }else{
                
                self.typePickerView.alpha = 0
            }
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIViewAnimationOptions.curveLinear, animations: {
                
                if (!self.hiddingOperation){
                    
                    self.typePickerView.alpha = 1
                }else{
                    
                    if(self.statePickerAction){
                        
                        self.countryLabel.frame.origin.y = self.countryLabel.frame.origin.y - self.typePickerView.frame.size.height - 8
                        self.pickerCountryValue.frame.origin.y = self.pickerCountryValue.frame.origin.y - self.typePickerView.frame.size.height - 8
                        self.pickerCountryButton.frame.origin.y = self.pickerCountryButton.frame.origin.y - self.typePickerView.frame.size.height - 8
                        self.submitButton.frame.origin.y = self.submitButton.frame.origin.y-self.typePickerView.frame.size.height - 8
                    }else{
                        
                        self.submitButton.frame.origin.y = self.submitButton.frame.origin.y-self.typePickerView.frame.size.height - 8
                    }
                }
                
                }, completion: nil)
            
            self.hiddingOperation = !self.hiddingOperation
            self.statePickerAction = false
            
            }, completion: nil)
    }
    
}
