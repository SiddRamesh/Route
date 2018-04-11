//
//  EssentialViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 3/31/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

class EssentialViewController: UIViewController {

  //  @IBOutlet weak var scrollView: UIScrollView!
    
 //   @IBOutlet weak var tichImg: UIImageView! //= []
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var selectAllBtn: UIButton!
    @IBOutlet weak var deSelectAllBtn: UIButton!
    
    
    @IBOutlet weak var mobVu: CardVieww!
    @IBOutlet weak var tootVu: CardVieww!
    @IBOutlet weak var firstVu: CardVieww!
    @IBOutlet weak var waterVu: CardVieww!
    @IBOutlet weak var sunVu: CardVieww!
    @IBOutlet weak var handVu: CardVieww!
    @IBOutlet weak var sunSVu: CardVieww!
    @IBOutlet weak var portVu: CardVieww!
    
    @IBOutlet weak var mobImg: UIImageView!
    @IBOutlet weak var tootImg: UIImageView!
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var waterImg: UIImageView!
    @IBOutlet weak var sunImg: UIImageView!
    @IBOutlet weak var handImg: UIImageView!
    @IBOutlet weak var sunSImg: UIImageView!
    @IBOutlet weak var portImg: UIImageView!
    
  //  fileprivate var _subViews = [UIView]()
    
    @IBAction func selectAllTick(_ sender: Any) {
        
    
        mobImg.isHidden = false
        tootImg.isHidden = false
        firstImg.isHidden = false
        waterImg.isHidden = false
        sunImg.isHidden = false
        handImg.isHidden = false
        sunSImg.isHidden = false
        portImg.isHidden = false
    
    }
    
    @IBAction func deSelectAll(_ sender: Any) {
                
        mobImg.isHidden = true
        tootImg.isHidden = true
        firstImg.isHidden = true
        waterImg.isHidden = true
        sunImg.isHidden = true
        handImg.isHidden = true
        sunSImg.isHidden = true
        portImg.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     //   _subViews.append([mobVu,tootVu])
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(EssentialViewController.imageTapped(img:)))
//        portVu.isUserInteractionEnabled = true
//        portVu.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(img: AnyObject)
    {
        
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
