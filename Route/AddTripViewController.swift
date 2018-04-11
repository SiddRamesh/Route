//
//  AddTripViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 3/28/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import QuartzCore
import MapKit
import GooglePlaces

import AddressBook
import Contacts
import ContactsUI

//import TimelineTableViewCell

extension UIView {
    
    func setCardView(view : UIView){
        
        view.layer.cornerRadius = 5.0
        view.layer.borderColor  =  UIColor.clear.cgColor
        view.layer.borderWidth = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width:5, height: 5)
        view.layer.masksToBounds = true
    }
}


class AddTripViewController: UIViewController {

   // var horizontalContactsView: MEVHorizontalContactsExample1 = MEVHorizontalContactsExample1()

    var popupController:CNPPopupController?
    
    @IBOutlet weak var tableViewHeightLayout: NSLayoutConstraint!
  //   @IBOutlet weak var startBtnHeightLayout: NSLayoutConstraint!
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    var flag:Bool = false
    
    fileprivate var userArr = [[String: Any]]()
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileImageUpload: UIImageView!
    @IBOutlet var arrowImg: UIImageView!
    
     @IBOutlet var addContact: UIImageView!
    
    @IBOutlet weak var triptxtFeild: UITextField!
    @IBOutlet var addLocation: UIImageView!
    
    @IBOutlet var dotView: UIImageView!
    
    @IBOutlet var placeView: UIView!
    @IBOutlet var calenderView: UIView!
    
    @IBOutlet var fromCalenderView: UIView!
    @IBOutlet var toCalenderView: UIView!
     @IBOutlet var contactListView: UIView!
    
    @IBOutlet var mapView: UIView!
    
    @IBOutlet var placeLbl: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var fromDateMLabel: UILabel!
    @IBOutlet weak var fromDateDLabel: UILabel!
    
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var toDateMLabel: UILabel!
    @IBOutlet weak var toDateDLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var startBuildingbtn: UIButton!
    
    var Cobjects = [Any]()
    var objects = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
  //      horizontalContactsView = MEVHorizontalContactsExample1()
        
        mapView.isHidden = true
        
        self.searchCompleter.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        self.arrowImg.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        addTripName()
        
        usersCollectionView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        startBuildingbtn.layer.cornerRadius = 5
        startBuildingbtn.layer.masksToBounds = true
        
        fromCalenderView.isHidden = true
        toCalenderView.isHidden = true
        
      //  self.placeLbl.text = "Add Cities here"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddTripViewController.imageTapped(img:)))
        profileImageUpload.isUserInteractionEnabled = true
        profileImageUpload.addGestureRecognizer(tapGestureRecognizer)
        
//        let addLoctapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddTripViewController.onLaunchClicked(sender:)))
//        addLocation.isUserInteractionEnabled = true
//        addLocation.addGestureRecognizer(addLoctapGestureRecognizer)

//        let addContacttapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddTripViewController.click_Contact(_:)))
//        addContact.isUserInteractionEnabled = true
//        addContact.addGestureRecognizer(addContacttapGestureRecognizer )
        
        contactListView.isHidden = true
        
    }
    
    @objc func presentMap() {
        DispatchQueue.main.async {
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            let navViewController = storyboard.instantiateViewController(withIdentifier: "Map")
//            self.present(navViewController, animated: true)
            self.mapView.isHidden = false
        }
    }
    
    // Keyboard Hiding...
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTripViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.tableView.layoutSubviews()
        
        tableViewHeightLayout.constant = CGFloat(objects.count + 1) * tableViewHeightLayout.constant
       //  placeLbl.text = searchPlace.Mcity
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var timestamp:String = " "
    
    let mobile = "987654321"
    var trip_name = "N/A"
  //  var cities = [Any]
    let city_id = ""
    var from_date = ""
    var to_date = ""
    let country_codes = [Locale.current.regionCode]
    var group_key = UUID().uuidString
    let group_name = SO_TIMESTAMP
    let group_id = arc4random()
    let picture = ""
    var placeID = " "
    let cC_id = ["qwertyuiop","asdfghjkl","zxcvbnm"]
//    let cList = ["Goa","Mumbai","Pune"]
//    let cName = ["Rob","Adam","Sam"]
//    let cNum = [arc4random(),arc4random(),arc4random()]
//    let cCode = ["91","91","91"]
//    var gId = [arc4random(), arc4random()]
//    var gKey = UUID().uuidString
}

extension AddTripViewController {
    
     func presentRouteMap() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navViewController = storyboard.instantiateViewController(withIdentifier: "MyTrip")
            self.present(navViewController, animated: true)
        }
    }
    
    func webAddTrip(onCompletion: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        self.trip_name = triptxtFeild.text!
        
        SVProgressHUD.show()
        let params:NSMutableDictionary? =  ["mobile_no" : 9819798769,
                                            "trip_name" : self.trip_name,
                                            "group_key" : group_key,
                                            "cities" : "\(objects)",
                                            "city_id" : "\(cC_id)",
                                            "from_date" : "05-March-2018",
                                            "to_date" : "15-March-2018",
                                            "contact_names" : "\(userArr)",
                                            "contact_number" : "\(userArr)",
                                            "country_codes" : "\(country_codes)",
                                            "group" : "Gro",
                                            "group_id" : "\(group_id)",
                                            "picture" : ""]
        
        let theJSONData = try? JSONSerialization.data(withJSONObject: params as Any ,options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: theJSONData!, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            print(json)
        }
        let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/trips/add_edit_trip/")
        let theRequest = NSMutableURLRequest.init(url: urlString!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        
        let dataTask = URLSession.shared.dataTask(with: theRequest as URLRequest) { data, response, error in
            if((error) != nil) { // self.que.addOperation { }
                print(error!.localizedDescription)
            } else { // For Debuging...
                let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                print("Response is ->",str as Any)
                do {
                    print("Deserializing JSON...")
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(json)
                    self.presentMap()
                } catch {
                    print("Error Deserializing JSON: \(error)")
                }
            }
        }
        dataTask.resume()
        print("Searching Data...",theRequest)
    }
}


extension AddTripViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return objects.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  //as! TimelineTableViewCell
   
        if (indexPath.row > 1) {
             cell.imageView?.image = UIImage.init(named: "dots-clear")
        }
        
        let object = objects[indexPath.row] as! String
        cell.textLabel!.text = object.description
        cell.imageView?.image = UIImage.init(named: "dots-clear")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension AddTripViewController : UITableViewDelegate  {
    
}

class UIDynamicTableView: UITableView
{
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: self.contentSize.height)
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}


class usersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblUserName.textAlignment = .center
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
        self.imgView.layer.borderColor = UIColor.red.cgColor
        self.imgView.layer.borderWidth = 3
        self.imgView.clipsToBounds = true
    }
}

// MARK: - UICollectionViewDataSource
extension AddTripViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  userArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! usersCollectionViewCell
        
        cell.imgView.image = UIImage(named: userArr[indexPath.row]["image"] as! String) // UIImage.init(data: userArr[indexPath.row]["image"] as! String)
        cell.lblUserName.text = userArr[indexPath.row]["name"]! as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        remCon((userArr[indexPath.row]["name"]! as? String)!)
        if self.flag == true {
            userArr.remove(at: Int(indexPath.row))
        }
        self.usersCollectionView.reloadData()
        self.flag = false
    }
}

//MARK: Google Places
extension AddTripViewController : GMSAutocompleteViewControllerDelegate {
    
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
        print("Place ID: \(place.placeID )")
        print("Place cooridnates: \(place.coordinate )")
        self.placeLbl.text = " " // place.formattedAddress
        objects.insert(place.formattedAddress as Any, at: objects.endIndex)
        let indexPath =  IndexPath(row: 0, section: 0) 
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // Place Photo
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                print(placeID)
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
              //  self.imageView.image = photo;
              //  self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}

//MARK: Image Picker
extension AddTripViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profileImage.image = chosenImage
        
        // To dismiss the image picker
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Contact
class ContactsHandler: NSObject,CNContactPickerDelegate {
    static let sharedInstance = ContactsHandler()
    
    var contactStore = CNContactStore()
    var parentVC: UIViewController!
    
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                        print(message);
                    }
                }
            })
            
        default:
            completionHandler(false)
        }
    }
    
    @objc func openAddressbook(vc: UIViewController){
        requestForAccess { (accessGranted) in
            if accessGranted == true{
                self.parentVC = vc;
                let controller = CNContactPickerViewController()
                controller.delegate = self
                vc.present(controller,animated: true, completion: nil)
            }
        }
    }
    
//    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
//
//        if contact.isKeyAvailable(CNContactPhoneNumbersKey){
//            // handle the single selected contact
//        }
//    }
    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        print("Cancelled picking a contact")
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]){
        for contact in contacts{
            if contact.isKeyAvailable(CNContactPhoneNumbersKey){
                // handle seleted contacts here
            }
        }
    }
}

extension AddTripViewController : CNContactPickerDelegate {
    
    @IBAction func click_Contact(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            var conImg = "user" //Data.init(base64Encoded: "user")! //"user"
            if contact.imageDataAvailable {
                conImg =  (contact.thumbnailImageData as AnyObject) as! String
            }
            let name = contact.givenName
            userArr.append(["name" : contact.givenName,"number" : contact.phoneNumbers, "image" : conImg])
            usersCollectionView.reloadData()
            timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .medium)
            self.group_key = timestamp + name 
      //    contactListView.isHidden = false
            print(name, " -> number )")
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print(name, " -> number is = \(phoneNumber)")
            }
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
}

//MARK: MapKit Delegate
extension AddTripViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            self.searchCompleter.queryFragment = searchText
        }
    }
}

extension AddTripViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
            self.searchResultsTableView.reloadData()
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension AddTripViewController : CNPPopupControllerDelegate {
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")
    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
    }
}

extension AddTripViewController {
    
    func addTripName() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.center
        
        let title = NSAttributedString(string: "Add Trip Name", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24), NSAttributedStringKey.paragraphStyle: paragraphStyle])
        
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        
        //Bill
        let billTextField = UITextField.init(frame: CGRect(x: 10, y: 10, width: 230, height: 35))
        billTextField.borderStyle = UITextBorderStyle.roundedRect
        billTextField.placeholder = "Your trip name..."
        
        // All
        let button = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("OK", for: UIControlState())
        
        button.backgroundColor = UIColor.init(red: 220.0 / 255.0, green: 109.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
        
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (button) -> Void in
            self.popupController?.dismiss(animated: true)
            //  print("Block for button: \(button.titleLabel?.text)")
            self.triptxtFeild.text = billTextField.text
        }
        
        let popupController = CNPPopupController(contents:[titleLabel,billTextField, button])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = .centered
        // LFL added settings for custom color and blur
        popupController.theme.maskType = .custom
        popupController.theme.customMaskColor = UIColor.init(white: 0.0, alpha: 0.7)
        popupController.theme.blurEffectAlpha = 1.0
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
    
    func remCon(_ nam:String) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.center
        
        let title = NSAttributedString(string: "Delete \(nam)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24), NSAttributedStringKey.paragraphStyle: paragraphStyle])
        
        let title1 = NSAttributedString(string: "Are you sure !", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.paragraphStyle: paragraphStyle])
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        
        let titleLabel1 = UILabel()
        titleLabel1.numberOfLines = 0;
        titleLabel1.textColor = .red
        titleLabel1.attributedText = title1
        
        // All
        let button = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("YES", for: UIControlState())
        
        button.backgroundColor = UIColor.init(red: 220.0 / 255.0, green: 109.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
        
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (button) -> Void in
            self.popupController?.dismiss(animated: true)
            self.flag = true
            print(self.flag)
            //  print("Block for button: \(button.titleLabel?.text)")
        }
        
        let popupController = CNPPopupController(contents:[titleLabel,titleLabel1, button])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = .centered
        // LFL added settings for custom color and blur
        popupController.theme.maskType = .custom
        popupController.theme.customMaskColor = UIColor.clear
        popupController.theme.blurEffectAlpha = 1.0
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
}

/*
extension AddTripViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.attributedText = highlightedText(searchResult.title, inRanges: searchResult.titleHighlightRanges, size: 17.0)
        cell.detailTextLabel?.attributedText = highlightedText(searchResult.subtitle, inRanges: searchResult.subtitleHighlightRanges, size: 12.0)
        cell.contentView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        return cell
    }
}

extension AddTripViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let city = response?.mapItems[0].placemark.subAdministrativeArea //   coordinate
            let sub = response?.mapItems[0].placemark.administrativeArea
            let country = response?.mapItems[0].placemark.country
            self.placeLbl.text = city! + ", " + sub! + ", " + country!
            self.placeLbl.textColor = .black
            self.mapView.isHidden = true
            self.view.addSubview(self.placeView)
        }
    }
}
*/


extension AddTripViewController : CalendarDateRangePickerViewControllerDelegate {
    
    @IBAction func didTapButton(_ sender: Any) {
        let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        dateRangePickerViewController.delegate = self
        dateRangePickerViewController.minimumDate = Date()
        dateRangePickerViewController.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        dateRangePickerViewController.selectedStartDate = Date()
        dateRangePickerViewController.selectedEndDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())
        dateRangePickerViewController.selectedColor = UIColor.red
        dateRangePickerViewController.titleText = "Select Date Range"
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func didCancelPickingDateRange() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func didPickDateRange(startDate: Date!, endDate: Date!) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
//        print(dateFormatter.string(from: startDate) + " to " + dateFormatter.string(from: endDate))
        
        let fromdateFormatter = DateFormatter()
        
        fromdateFormatter.dateFormat = " d "
        fromDateLabel.text = fromdateFormatter.string(from: startDate)
        toDateLabel.text = fromdateFormatter.string(from: endDate)
        
        fromdateFormatter.dateFormat = "MMM"
        fromDateMLabel.text = fromdateFormatter.string(from: startDate)
        toDateMLabel.text = fromdateFormatter.string(from: endDate)
        
        fromdateFormatter.dateFormat = "EEEE"
        fromDateDLabel.text = fromdateFormatter.string(from: startDate)
        toDateDLabel.text = fromdateFormatter.string(from: endDate)
        
        
        self.from_date = String(describing: startDate)
        self.to_date = String(describing: endDate)
        
     // dateLabel.text = dateFormatter.string(from: startDate) + " to " + dateFormatter.string(from: endDate)
        calenderView.isHidden = true
        arrowImg.isHidden = false
        fromCalenderView.isHidden = false
        toCalenderView.isHidden = false
    //  fromDateLabel.text =
        
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}



