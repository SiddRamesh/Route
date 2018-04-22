//
//  Signup.swift
//  Route
//
//  Created by Ramesh Siddanavar on 3/22/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import Foundation
import UIKit
import Material

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.init(red: 220.0 / 255.0, green: 109.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    @IBInspectable var endColor: UIColor = UIColor.init(red: 217.0 / 255.0, green: 68.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        gradient.startPoint = CGPoint(x: 0.8, y: 0.2)
        gradient.endPoint = CGPoint(x: 0.3, y: 0.1)
     //   gradient.locations = [0.5, 0, 0.5, 0]
        layer.addSublayer(gradient)
    }
}

@IBDesignable
class CardVieww: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColorr: UIColor? = .black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColorr?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}

class Singleton {
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
}

class ShareData {
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
       //     static var token: 0 // dispatch_once_t = 0
        }
        
//        dispatch_once(&Static.token) {
            Static.instance = ShareData()
//        }
        
        return Static.instance!
    }
    var mobile : String!
    var password : String!
    
//    var selectedTheme : AnyObject! //Some Object
 //   var someBoolValue : Bool!
}

extension Signup {
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = Locale.current.regionCode! + "   Enter Your Mobile No."
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.placeholderAnimation = .hidden
        
        // Set the colors for the emailField, different from the defaults.
        //        emailField.placeholderNormalColor = Color.amber.darken4
        //        emailField.placeholderActiveColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        
        // Set the text inset
        //        emailField.textInset = 20
        
        let leftView = UIImageView()
        leftView.image = Icon.phone
        emailField.leftView = leftView
        
        view.layout(emailField).center(offsetY: -passwordField.bounds.height - 60).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 4 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(passwordField).center().left(20).right(20)
    }
}


extension Signup: TextFieldDelegate {
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


class Signup: UIViewController {

    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var profileStackView: UIStackView!
    @IBOutlet var pinStackView: UIStackView!
    @IBOutlet var passStackView: UIStackView!
    
    @IBOutlet weak var imgView: UIImageView!
  //  @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet var _first: UITextField!
    @IBOutlet var _last: UITextField!
    @IBOutlet var _dob: UITextField!
//    @IBOutlet var _gender: UITextField!
    @IBOutlet var _email: UITextField!
    @IBOutlet var _updateButton: UIButton!
    
    @IBOutlet var _mobile: TextField! // UITextField!
    @IBOutlet var _password: TextField! //UITextField!
    @IBOutlet var _loginButton: UIButton!
    
    @IBOutlet var _newPin: TextField! //UITextField!
    @IBOutlet var _confirmPin: UITextField!
    @IBOutlet var _saveButton: UIButton!
    
     let defaults = UserDefaults.standard
    
    @IBOutlet var errorText: UILabel!
    @IBOutlet var titleText: UILabel!
    var mobile = ""
    var password = ""
    var otpStr = ""
    
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
         self.hideKeyboardWhenTappedAround()
        passStackView.isHidden = true
        pinStackView.isHidden = true
        profileStackView.isHidden = true
        
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1)
        
     //   self._mobile.textAlignment = .left
        self._mobile.placeholder = Locale.current.regionCode! + "   Enter Your Mobile No."
        
        view.backgroundColor = Color.grey.lighten5
        
   //     preparePasswordField()
   //     prepareEmailField()
   //     prepareResignResponderButton()
        
    }
    
    /// Prepares the resign responder button.
    fileprivate func prepareResignResponderButton() {
        let btn = RaisedButton(title: "Save", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        
        view.layout(btn).width(100).height(constant).top(40).right(20)
    }
    
    /// Handle the resign responder button.
    @objc internal func handleResignResponderButton(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
    }
    
    // Keyboard Hiding...
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewControllerr.dismissKeyboard))
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
    
    @IBAction func loginButtonPress(_ sender: Any) {
        let username = _mobile.text
      //  let password = _password.text
        
        if(username == "") {
            return
        }
        self.mobile = username!
        //     self.coreLogin(username: username!, password: password!)
        self.webLogin(username: username!)
    }
    
     @IBAction func saveButtonPress(_ sender: Any) {
        pinConfig()
        self.shareData.mobile = mobile
        self.shareData.password = password
        print(mobile,password)
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navViewController = storyboard.instantiateViewController(withIdentifier: "Prof")
            self.present(navViewController, animated: true)
            self._mobile.text = self.mobile
            self._confirmPin.text = self.password
        }
    }
    
    func getData( mob:String, pin:String){

        var pin = pin
        var mob = mob
        mob = self.mobile
         pin = self.password
    }
    
     @IBAction func finalButtonPress(_ sender: Any) {

        log()
    }
    
     @IBAction func updateButtonPress(_ sender: Any) {
        
        webSignUp(username: self.mobile, password: self._confirmPin.text!)
    }

    //TODO: - Login
    func webLogin(username: String, onCompletion: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        
        if (self._mobile == nil ) {
            DispatchQueue.main.async { self.errorText.text = "Please Enter a Valid Mobile No." }
            return
        }
        
        let req = """
        mobile_no=\(username)
        """
        
     //   let defaults = UserDefaults.standard
        defaults.set(username, forKey: "mobile_no")
        defaults.synchronize()
        print("Default",username)
        
       
        let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/users/verify_mobile_number/")
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
                                        self.errorText.text = "Login Error! Plz Try Again"
                                        return
                                    }
                                    
                                    let ver = parseJSON["verified"] as! Int
                                    if (ver as AnyObject).isEqual(to: 0) {
                                        self.stackView.isHidden = true
                                        self.pinStackView.isHidden = false
                                        SVProgressHUD.dismiss()
                                        self.showAlertMessage(messageTitle: "OTP", withMessage: "Verified")
                                        self.titleText.text = "Generate Your 4 Digit PIN"
                                        self.errorText.text = "New User"
                                        print("New Username")
                                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                        return
                                    }
                                    
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        self.stackView.isHidden = true
                                        self.passStackView.isHidden = false
                                        self.titleText.text = "Enter Your PIN"
                                        print("Password")
                                        onCompletion?()
                                    })
                                    
                                } catch {
                                    print("Error Deserializing JSON: \(error)")
                                    self.errorText.text = "Login Error ! Plz Try Again"
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
    
    func presentMainView() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navViewController = storyboard.instantiateViewController(withIdentifier: "Menu")
            self.present(navViewController, animated: true)
            self._mobile.text = ""
            self._password.text = ""
        }
    }
    
    func showAlertMessage(messageTitle: String, withMessage: String) -> Void  {
        let alertController = UIAlertController(title: messageTitle as String, message: withMessage as String, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func log(){
        
        SVProgressHUD.show()
        self.passStackView.isHidden = false
        let url = URL(string: "http://sparkdeath324.pythonanywhere.com/users/verify_mobile_number/")
        guard url != nil else { return }
        let req = "mobile_no=\(self.mobile)&pin=\(self._password.text ?? "N/A")"
        
        let pass:String = self._password.text!
        let theRequest = NSMutableURLRequest.init(url: url!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        theRequest.httpMethod = "POST"
        theRequest.httpBody = req.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: theRequest as URLRequest) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Error while Fetching data...")
                return
            }
            do {
                print("Deserializing JSON...")
                if  (try JSONSerialization.jsonObject(with: data) as? [String: Any]) != nil {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print(json)
                //    DispatchQueue.main.async {
                    guard let parseJSON = json as? [String:Any],
               //   self._password.text == (parseJSON["PIN"] as! String)
                    pass == (parseJSON["PIN"] as! String)
                    else {
                        print("PIN Missmatch")
                        DispatchQueue.main.async { SVProgressHUD.dismiss(withDelay: 1); self.errorText.text = "Login Error! Plz Try Again" }
                        return
                      }
             //       }
                    SVProgressHUD.dismiss()
                    self.presentMainView()
                }
            } catch {
                print("Error Deserializing JSON: \(error)")
            }
        }.resume()
    }
    
    func pinConfig() {

        self.pinStackView.isHidden = true
        
        let pass:String = self._newPin.text!
        if pass.count > 4 {
            self.errorText.text = "Max 4 Digit PIN"
            return
        }
        
        if self._newPin.text == self._confirmPin.text {
             self.password = self._confirmPin.text!
            //     self.profileStackView.isHidden = false
            self.titleText.text = " "
            defaults.set(self._confirmPin.text, forKey: "pin")
            defaults.synchronize()
        //    print("Default",username)
            self.errorText.text = "Plz Update ur Details. ."
        } else {
            self.pinStackView.isHidden = false
            self.errorText.text = "PIN Don't Match"
            return
        }
  
    }
    
    //TODO: - Login ......Not used
    func webSignUp(username: String, password: String, onCompletion: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        pinStackView.isHidden = true
        profileStackView.isHidden = false
        SVProgressHUD.show()
        self.titleText.text = " "
        self.errorText.text = "Plz Update ur Details. ."
        
        if (self._mobile == nil) {
            DispatchQueue.main.async { self.errorText.text = "Invalid Mobile No." }
            return
        }
        
        let req = """
        first_name=\(self._first.text  ?? "N/A")
        &last_name=\(self._last.text  ?? "N/A")
        &pin=\(self._confirmPin.text  ?? "N/A")
        &dob=\(self._dob.text!)
        &gender=\("Male")
        &push_id=\("8867")
        &mobile_no=\(self._mobile.text ?? "N/A")
        &verified=\("1")
        &email=\(self._email.text  ?? "N/A")
        &login_type=\("Partner")
        """
     //   print(req)
        let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/users/update_userinfo/")
        
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
                                        self.errorText.text = "Login Error ! Plz Try Again"
                                        return
                                    }
                                    self.presentMainView()
                                    print(parseJSON["first_name"] as Any)
                                    
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        onCompletion?()
                                    })
                                    
                                } catch {
                                    print("Error Deserializing JSON: \(error)")
                                    self.errorText.text = "Login Error! Plz Try Again"
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
