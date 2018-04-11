//
//  MemoryViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 4/2/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController, VBPiledViewDataSource {
    
    @IBOutlet var piledView: VBPiledView!
    
    fileprivate var _subViews = [UIView]()
    
    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.piledView.expandedContentHeightInPercent = 70 // expanded content height -> 70% of screen
        self.piledView.collapsedContentHeightInPercent = 15 // collapsed content heigt of single item -> 15% of screen
        
        _subViews.append(UIImageView(image: UIImage(named: "1.png")))
        _subViews.append(UIImageView(image: UIImage(named: "3.png")))
        _subViews.append(UIImageView(image: UIImage(named: "4.png")))
        _subViews.append(UIImageView(image: UIImage(named: "5.png")))
        _subViews.append(UIImageView(image: UIImage(named: "bigban.jpg")))
        _subViews.append(UIImageView(image: UIImage(named: "libertystate.jpg")))
        _subViews.append(UIImageView(image: UIImage(named: "Moonrise.jpg")))
        
        for v in _subViews{
            v.contentMode = UIViewContentMode.scaleAspectFill
            v.clipsToBounds = true
            v.backgroundColor = UIColor.gray
        }
        piledView.dataSource = self
        
        //Phot Upload ..
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
        self.imgView.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector( MemoryViewController.imageTapped(img:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    func piledView(_ numberOfItemsForPiledView: VBPiledView) -> Int {
        return _subViews.count
    }
    
    func piledView(_ viewForPiledView: VBPiledView, itemAtIndex index: Int) -> UIView {
        return _subViews[index]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK: Image Picker
extension MemoryViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imageTapped(img: AnyObject)
    {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Upload", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("upload")
            self.showPhotos()
        })
      
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(deleteAction)
     //   optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func showPhotos() {
        // Check if the device has a camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            // Device has a camera, now create the image picker controller
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            _subViews.append(UIImageView(image: chosenImage))
         self.dismiss(animated: true, completion: nil)
    }
    
//    @objc func imagePickerController(_ picker: UIImagePickerControllerDelegate, didf
//
//
//         self.dismiss(animated: true, completion: nil)
//    }
    
}









