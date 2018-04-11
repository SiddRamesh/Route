//
//  ProfViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 3/26/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit
import Material
import Lottie
import Photos

class ProfViewController: UIViewController {

    fileprivate var emailField: ErrorTextField!
    fileprivate var fField: ErrorTextField!
    fileprivate var lField: ErrorTextField!
    fileprivate var dField: ErrorTextField!
    fileprivate var mField: ErrorTextField!
//    fileprivate var gField: ErrorTextField!
 //   fileprivate var dateTextField: ErrorTextField!
    fileprivate var passwordField: TextField!
    fileprivate let constant: CGFloat = 32
    var timestamp:String = " "
    var gender:String = " "
    
     @IBOutlet var profileImage: UIImageView!
    
    let shareData = ShareData.sharedInstance
    var sig:Signup = Signup()
    
    @IBOutlet var inputPut: UIView!
    @IBOutlet var profileImageUpload: UIImageView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .medium)
   //     self.dField.text = timestamp
        inputPut.backgroundColor = Color.white

        preparePasswordField()
        prepareEmailField()
        preparemField()
        preparefField()
        preparelField()
        preparedobField()
        prepareResignResponderButton()
        initDatePicker()
        
        let animationView = LOTAnimationView(name: "spinner_")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = true
        view.addSubview(animationView)
        animationView.play { (finished) in
            // TODO
            
//            let sig = Signup()
//            self.passwordField.text = sig.password
//            self.mField.text = sig.mobile
//            print(self.mField.text as Any)
        }
        
        sig = Signup()
        sig.getData(mob: self.mField.text!, pin: self.passwordField.text!)
        self.passwordField.text = self.shareData.password  // sig.password
        self.mField.text =  self.shareData.mobile //  sig.mobile
    //    print("Mobile -> " + self.shareData.mobile)

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ProfViewController.imageTapped(img:)))
        profileImageUpload.isUserInteractionEnabled = true
        profileImageUpload.addGestureRecognizer(tapGestureRecognizer)
        
        animationView.removeFromSuperview()
        
        self.profileImage.layer.cornerRadius = 25 //self.profileImage.frame.size.width / 2
        self.profileImage.layer.masksToBounds = true
        //self.profileImage.clipsToBounds = true;
    }
    
    @objc func imageTapped(img: AnyObject)
    {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Upload", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("upload")
            self.showPhotos()
        })
        let saveAction = UIAlertAction(title: "Take Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("take photo")
            self.showCamera()
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
    
    /// Prepares the resign responder button.
    fileprivate func prepareResignResponderButton() {
        let btn = RaisedButton(title: "Save", titleColor: Color.white)
        btn.backgroundColor = Color.deepOrange.lighten1 // Color.green.lighten1
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        inputPut.layout(btn).width(100).height(constant).top(390).right(110)
    }
    
    /// Handle the resign responder button.
    @objc internal func handleResignResponderButton(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        webSignUp()
        presentMainView()
    }
    
    func presentMainView() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navViewController = storyboard.instantiateViewController(withIdentifier: "Home")
            self.present(navViewController, animated: true)
        }
    }
    
    // Keyboard Hiding...
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfViewController {
    fileprivate func preparemField() {
        mField = ErrorTextField()
        mField.placeholder = "Mobile No."
        mField.detail = "Error"
        mField.isClearIconButtonEnabled = true
        mField.delegate = self
        mField.isPlaceholderUppercasedWhenEditing = true
        mField.placeholderAnimation = .hidden
        
        let leftView = UIImageView()
        leftView.image = Icon.phone
        mField.leftView = leftView
        
        inputPut.layout(mField).center(offsetY: -140).left(20).right(20)
    }
    
    fileprivate func preparefField() {
        fField = ErrorTextField()
        fField.placeholder = "Enter Your First Name"
        fField.detail = "Error"
        fField.isClearIconButtonEnabled = true
        fField.delegate = self
        fField.isPlaceholderUppercasedWhenEditing = true
        fField.placeholderAnimation = .hidden
        
        let leftView = UIImageView()
        leftView.image = Icon.pen
        fField.leftView = leftView
        
        inputPut.layout(fField).center(offsetY: -90).left(20).right(20)
    }
    
    fileprivate func preparelField() {
        lField = ErrorTextField()
        lField.placeholder = "Enter Your Last Name"
        lField.detail = "Error"
        lField.isClearIconButtonEnabled = true
        lField.delegate = self
        lField.isPlaceholderUppercasedWhenEditing = true
        lField.placeholderAnimation = .hidden
        
        let leftView = UIImageView()
        leftView.image = Icon.pen
        lField.leftView = leftView
        
        inputPut.layout(lField).center(offsetY: -40).left(20).right(20)
    }
    
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.keyboardType = .emailAddress
        emailField.placeholder = "Enter Your e-mail Address."
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.placeholderAnimation = .hidden
        
        let leftView = UIImageView()
        leftView.image = Icon.email
        emailField.leftView = leftView
        
        inputPut.layout(emailField).center(offsetY: 10).left(20).right(20) // offsetY: -passwordField.bounds.height - 60
    }
    
    fileprivate func preparedobField() {
        dField = ErrorTextField()
        dField.placeholder = "Enter Your D.O.B"
        dField.detail = "Date Format Error"
        dField.isClearIconButtonEnabled = true
        dField.delegate = self
        dField.isPlaceholderUppercasedWhenEditing = true
        dField.placeholderAnimation = .hidden
        
        let leftView = UIImageView()
        leftView.image = Icon.cm.bell
        dField.leftView = leftView
        
        inputPut.layout(dField).center(offsetY: 60).left(20).right(20) // offsetY: -passwordField.bounds.height - 60
    }
    
    // Date Picker....
    func initDatePicker()  {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        dField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ProfViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
     //   dateFormatter.dateFormat = "dd/MM/yyyy"
          dateFormatter.dateStyle = .medium
     //   dateFormatter.locale = Locale(identifier: "en_IN")
        dField.text = dateFormatter.string(from: sender.date)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "PIN"
        passwordField.detail = "Confirm Your PIN"
        passwordField.clearButtonMode = .whileEditing
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
    //   inputPut.layout(passwordField).center(offsetY: 150).left(20).right(20)
    }
}

extension ProfViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showCamera() {
        // Check if the device has a camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            // Device has a camera, now create the image picker controller
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        else {
            NSLog("No Camera")
        }
    }
    
    func showPhotos() {
        // Check if the device has a camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            // Device has a camera, now create the image picker controller
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // To dismiss the image picker
        self.dismiss(animated: true, completion: nil)
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profileImage.image = chosenImage
      //  // Do whatever you wish with the image
    }
}

extension ProfViewController : TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}

extension ProfViewController {
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 0 { // segmentControl
            self.gender = "Male"
        } else if segmentControl.selectedSegmentIndex == 1 {
            self.gender = "Female"
        } else {
            self.gender = "Other"
        }
        
        print(self.gender)
    }
    
    func showAlertMessage(messageTitle: String, withMessage: String) -> Void  {
        let alertController = UIAlertController(title: messageTitle as String, message: withMessage as String, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}


extension ProfViewController {
    
    //TODO: - Login
    func webSignUp(onCompletion: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        if (self.shareData.mobile == nil) {
            DispatchQueue.main.async {  self.showAlertMessage(messageTitle: "Error", withMessage: "Invalid Mobile No.") }
            return
        }
        
        print(self.shareData.mobile)
        print(self.shareData.password)
        print("Mobile -> " + self.shareData.mobile)
        
        let req = """
        first_name=\(self.fField.text  ?? "N/A")&last_name=\(self.lField.text  ?? "N/A")&pin=\(self.passwordField.text  ?? "N/A")&dob=\(self.dField.text!)&gender=\(self.gender )&push_id=\("iOS_\(self.timestamp)")&mobile_no=\(self.shareData.mobile ?? "N/A")&verified=\("1")&email=\(self.emailField.text  ?? "N/A")&login_type=\("Partner")
        """
        
        print(req)
        let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/users/update_userinfo/")
        SVProgressHUD.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let theRequest = NSMutableURLRequest.init(url: urlString!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        theRequest.httpMethod = "POST"
        theRequest.httpBody = req.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let dataTask = URLSession.shared.dataTask(with: theRequest as URLRequest) { data, response, error in
            if((error) != nil) {
                print(error!.localizedDescription)
            }else { // For Debuging...
                //   let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                //     print("String is ->",str as Any)
                DispatchQueue.main.async {
                    print("The following Users are available:")
                    OperationQueue.main.addOperation {
                        if (response != nil) {
                            if response?.mimeType == "application/json" {
                                
                                do {
                                    print("Deserializing JSON...")
                                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                                    print(json)
                                    guard let parseJSON = json as? [String:Any] else {
                                        print("error")
                                   self.showAlertMessage(messageTitle: "Error", withMessage: "Login Error ! Plz Try Again")
                                        return
                                    }
                                    self.presentMainView()
                                    print(parseJSON["first_name"] as Any)
                                    
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        onCompletion?()
                                    })
                                    
                                } catch {
                                    print("Error Deserializing JSON: \(error)")
                                  self.showAlertMessage(messageTitle: "Error", withMessage: "Login Error ! Plz Try Again")
                                }
                                
                                print("Loging In..")
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                SVProgressHUD.dismiss()
                            }
                        } else {
                            print(Error.self)
                        }//else
                    }
                }
                print("Authorized")
            }
        }
        dataTask.resume()
        print("Searching Data...",theRequest)
    }
}




