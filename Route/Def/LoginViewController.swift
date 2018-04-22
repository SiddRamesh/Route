//
//  LoginViewController.swift
//  RFIDDemoApp
//
//  Created by Ramesh Siddanavar on 2/28/18.
//  Copyright © 2018 Motorola Solutions. All rights reserved.
//

import UIKit
//import CoreData
//import Animi

class LoginViewControllerr: UIViewController {
    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet var _button: UIButton!
    @IBOutlet var errorText: UILabel!
    var capStr:String = " "
    var usr:String? = nil
    var pid:String? = nil
    let defaults = UserDefaults.standard
    
 //   var user:[User]? = nil
  //  var modalView = AOModalStatusView()
  //  let core:CoreDataHandler = CoreDataHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
       //  Do any additional setup after loading the view.
  //      modalView = AOModalStatusView(frame: self.view.bounds)
 //       modalView.setAll(image: #imageLiteral(resourceName: "complete"), headline: "Logged Out", subHead: "Success")
 //       view.addSubview(modalView)
        
        self.hideKeyboardWhenTappedAround()
        
     //   CoreDataHandler.saveObject(username: "Admin", password: "12345")
     //   CoreDataHandler.saveObject(username: "ADMIN", password: "x")
//        user = CoreDataHandler.fetchObject()
//        for i in user! {
//            print("Username: \(i.username!)\nPassword: \(i.password!)")
//        }
    }
    
//    func getUsr() -> [User] {
//        user = CoreDataHandler.fetchObject()//    filterData()
//        for i in user! {
//           //  if i.username == self.usr! && i.password == self.pid! {
//                print("User: \(i.username!)\nPass: \(i.password!)")
//                self.usr = i.username
//                self.pid = i.password
//         //   }
//        }
//        return user!
//    }

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    enum APIError: Error {
        case parseError(String)
        case usernameMismatch(String)
    }
    
    func presentMainView() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navViewController = storyboard.instantiateViewController(withIdentifier: "Home") ///as! UINavigationController
            self.present(navViewController, animated: true)
            self._username.text = ""
            self._password.text = ""
        }
    }
    
     @IBAction func signUpButtonPress(_ sender: Any) {
  
//        print("Before Single Delete")
//        for i in user! {
//            print(i.username!)
//        }
        
//        if CoreDataHandler.deleteObject(user: user![0]) {
//            user = CoreDataHandler.fetchObject()
//            print("After Single Delete")
//            for i in user! {
//                print(i.username!)
//            }
//            print(user?.count as Any)
//        }
//
//        if CoreDataHandler.cleanDelete() {
//            user = CoreDataHandler.fetchObject()
//            print(user?.count as Any)
//        }
    }
    
    @IBAction func loginButtonPress(_ sender: Any) {
        let username = _username.text
        let password = _password.text
        
        if(username == "" || password == "") {
            return
        }
        
    //     self.coreLogin(username: username!, password: password!)
        self.webLogin(username: username!,password: password!)
    }
    
//    func coreLogin(username: String, password: String) {
//        user = CoreDataHandler.fetchObject()
//        if (CoreDataHandler.fetchObject() != nil) {
//            for i in user! {
//                if i.username == username && i.password == password {
//                    modalView.showActivityView(view)
//                    self.presentMainView()
//                    print("Success " ,i.username as Any)
//                }
//             //   modalView.setAll(image: #imageLiteral(resourceName: "cancel"), headline: "Login", subHead: "Failed")
//                errorText.text = "Login Error ! Plz Try Again"
//            }
//        }
//    }
    
    
    //TODO: - Login
    func webLogin(username: String, password: String, onCompletion: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
    //    self.modalView.showActivityView(view)
//        let req = """
//        mobile_no=\(username)&pin=\(password)
//        """
        let req = """
        mobile_no=\(username)
        """
        
   //     let defaults = UserDefaults.standard
        defaults.set(username, forKey: "mobile_no")
        defaults.synchronize()
        print(username)
        
    //    let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/users/get_userinfo/")
        let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/users/verify_mobile_number/")

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let theRequest = NSMutableURLRequest.init(url: urlString!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
    //    theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    //    theRequest.addValue(String(soapMessage.count), forHTTPHeaderField: "Content-Length")
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
                                    print(parseJSON["first_name"] as Any)
//                                    guard let usernameValue = parseJSON["mobile_no"] as? String,
//                                        usernameValue == username else {
//                                            DispatchQueue.main.async {  print("Username Invalid") }
//                                            self.errorText.text = "Username Invalid"
//                                            return
//                                    }
                                    guard let passwordValue = parseJSON["PIN"] as? String,
                                        passwordValue == password else {
                                            print("Incorrect Password")
                                            DispatchQueue.main.async { self.errorText.text = "Login Error ! \n Plz Check Mobile No. or Pin" }
                                            return
                                    }
                                    
//                                    guard let stat = parseJSON["status"] as? String,
//                                        stat == "success" else {
//                                            print("Incorrect Password")
//                                            DispatchQueue.main.async { self.errorText.text = "Login Error ! Plz Try Again" }
//                                            return
//                                    }
                                    
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        self.presentMainView()
                                        onCompletion?()
                                    })
                                    
                                } catch {
                                    print("Error Deserializing JSON: \(error)")
                                    self.errorText.text = "Login Error ! Plz Try Again"
                                }
                                
                                print("Loging In..")
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                           //     self.modalView.hideActivityView()
                            }
                        } else {
                            print(Error.self)
                        }//else
                    }
                }
                if (self._username == nil || self._password == nil) {
                    onError?(APIError.usernameMismatch("Usernames do not match!"))
                    DispatchQueue.main.async { self.errorText.text = "Invalid Login! Plz Try Again" }
                 //   self.modalView.setAll(image: #imageLiteral(resourceName: "cancel"), headline: "Login", subHead: "Failed")
                 //   view.addSubview(self.modalView)
                    return
                }// else {
                print("Authorized")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
               //  CoreDataHandler.saveComp(comp: self.usr!, pk: self.pid!)
//                    DispatchQueue.main.async(execute: { () -> Void in
//                        self.presentMainView()
//                        onCompletion?()
//                    })
           //     }
            }
        }
        dataTask.resume()
        print("Searching Data...",theRequest)
    }
}
