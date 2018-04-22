//
//  Created by Ramesh Siddanavar on 4/2/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//
import UIKit
import Material
import Graph

extension UIImage {
    public class func load(contentsOfFile name: String, ofType type: String) -> UIImage? {
        return UIImage(contentsOfFile: Bundle.main.path(forResource: name, ofType: type)!)
    }
}

extension UIImage {
    public class func load64(contentsOfFile name: String) -> UIImage? {
        return UIImage(contentsOfFile: Bundle.main.path(forAuxiliaryExecutable: name)!)
    }
}

extension String {
    
    func base64ToImg() -> UIImage? {
        
//        if let imageURL = URL(string: mov[indexPath.row].Poster) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageURL)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.postTab.image = image
//                    }
//                }
//            }
//        }
        
        if let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: decodedData)
        }
        return nil
      }
}

struct AllTrip : Decodable {
    
    let trip_name:String!
//  let group_name:String = ""
    let group_key:String! // = ""
    let group_id:String! // = ""
    let picture:String! // = ""
    let from_date:String!
    let to_date:String!
    let contact_name:String!
 //   let created_by:String!
    
    enum CodingKeys: String, CodingKey {
        case trip_name = "trip_name"
    //  case group_name// = "group_name"
        case group_key = "group_key"
        case group_id = "group_id"
        case picture = "picture"
        case from_date = "from_date"
        case to_date = "to_date"
        case contact_name = "contact_name"
//        case created_by_name = "created_by_name"
    }
}

struct SampleData {

    public func getTrips(tim:String) {
    var trip = [AllTrip]()
        // DispatchQueue.main.async { }
   //     var js = JSON()
        
        let defaults = UserDefaults.standard
        let mob = defaults.string(forKey: "mobile_no") as String?
        print(mob ?? "9004368224")
        
        SVProgressHUD.show()
        let urlString = URL(string: "http://sparkdeath324.pythonanywhere.com/trips/get_all_trips/")
        let params:NSMutableDictionary? =  ["mobile_no" : mob ?? "9004368224", "trip_time":tim]
        let theJSONData = try? JSONSerialization.data(withJSONObject: params as Any ,options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: theJSONData!, encoding: String.Encoding.utf8.rawValue)
        if json != nil {
         //   print(json)
        }
        let theRequest = NSMutableURLRequest.init(url: urlString!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        
        let dataTask = URLSession.shared.dataTask(with: theRequest as URLRequest) { data, response, error in
            if((error) != nil) { // self.que.addOperation { }
                print(error!.localizedDescription)
            } else { // For Debuging...
               //   let str = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
              //    print("Response is ->",str as Any)
                do
                {
                trip = try JSONDecoder().decode([AllTrip].self, from: data!)
                //    self.allTrips = trip
                //print(trip)
                      self.createSampleData(trip : trip)
              //       self.createPastData(pastTrip: trip)
              //      self.createPresentData(presentTrip: trip)
                    print("Decoding Data... Done")
                    SVProgressHUD.dismiss()
                } catch {
                    print("Error Decoding.... :(")
                }
            }
        }
        dataTask.resume()
        print("Searching Data...",theRequest)
    }
    
    public mutating func loadData() {
          getTrips(tim:"future")
      //  self.getTrips(tim:"past")
     //   self.getTrips(tim:"present")
    }
        
    public  func createSampleData(trip:[AllTrip]) { // static trip:[AllTrip]
        let graph = Graph()
        graph.clear()
        
            // Future ...
            let c1 = Entity(type: "Category")
            c1["name"] = "Future"

        for fut in trip {  DispatchQueue.main.async {
            let a1 = Entity(type: "Trips")

            a1["title"] =  fut.trip_name as String
            a1["detail"] =  "Created By : Admin" //+ fut.contact_name as String // + fut.created_by as String + " "
            a1["photo"] =  fut.picture.base64ToImg()  //  UIImage.load(contentsOfFile: "photo3", ofType: "png")?.resize(toHeight: 300) //
            a1["content"] = "From : " + fut.from_date as String + "    To : " + fut.to_date as String // + "with : " + fut.contact_name as String
            a1["posted"] = fut.group_id as String
            a1.is(relationship: "Post").in(object: c1)
          }
      }
 
        // Past ...
        let c2 = Entity(type: "Category")
        c2["name"] = "Past"
        
  //      for past in trip {
            let a3 = Entity(type: "Trips")
            a3["title"] = "past.trip_name as String"
            a3["detail"] = " http://sparkdeath324.pythonanywhere.com/"
            a3["photo"] = UIImage.load(contentsOfFile: "photo4", ofType: "png")?.resize(toHeight: 300)
            a3["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
            a3["posted"] = "25-May-2018"
            a3.is(relationship: "Post").in(object: c2)
        
 //       }
        
        // Ongoing ....
        let c3 = Entity(type: "Category")
        c3["name"] = "Ongoing"
        
    //    for present in trip {
            let a5 = Entity(type: "Trips")
            a5["title"] = "present.trip_name as String"
            a5["detail"] = " http://sparkdeath324.pythonanywhere.com/"
            a5["photo"] = UIImage.load(contentsOfFile: "photo2", ofType: "png")?.resize(toHeight: 300)
            a5["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!?"
            a5["posted"] = "25-May-2018"
            a5.is(relationship: "Post").in(object: c3)
 //       }
 
        graph.sync()
    }

    public func createPastData(pastTrip:[AllTrip]) {
        let graph = Graph()
        graph.clear()
    
        // Past ...
        let c2 = Entity(type: "Category")
        c2["name"] = "Past"
        
        for past in pastTrip {
            let a3 = Entity(type: "Trips")
            a3["title"] = past.trip_name as String
            a3["detail"] = " http://sparkdeath324.pythonanywhere.com/"
            a3["photo"] = UIImage.load(contentsOfFile: "photo4", ofType: "png")?.resize(toHeight: 300)
            a3["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
            
            a3.is(relationship: "Post").in(object: c2)
        }
        graph.sync()
    }
   /*
    public func createPresentData(presentTrip:[AllTrip]) {
        let graph = Graph()
        graph.clear()
        
        // Past ...
        let c2 = Entity(type: "Category")
        c2["name"] = "Past"
        
        for present in presentTrip {
            let a3 = Entity(type: "Trips")
            a3["title"] = present.trip_name as String
            a3["detail"] = " http://sparkdeath324.pythonanywhere.com/"
            a3["photo"] = UIImage.load(contentsOfFile: "photo4", ofType: "png")?.resize(toHeight: 300)
            a3["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
            
            a3.is(relationship: "Post").in(object: c2)
        }
        graph.sync()
    }
    */
}
