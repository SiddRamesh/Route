//
//  LoadViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 3/19/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    
    struct Constants {
        struct Gifs {
            static let catVideo = "cat-video"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         gifImageView.loadGif(name: Constants.Gifs.catVideo)
        // Do any additional setup after loading the view.
        
       hideKeyboardWhenTappedAround()
    }
    
    // Keyboard Hiding...
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoadViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
         presentMainView()
    }
    
    func presentMainView() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navViewController = storyboard.instantiateViewController(withIdentifier: "Sign")
            self.present(navViewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
