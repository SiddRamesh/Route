//
//  DailyTaskViewController.swift
//  Route
//
//  Created by Ramesh Siddanavar on 4/2/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

class DailyTaskViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 3
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setup()
    }
    
    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .clear // UIColor(patternImage: #imageLiteral(resourceName: "background"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - TableView
//import FoldingCell
extension DailyTaskViewController : UITableViewDataSource, UITableViewDelegate {
    
     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }
    
//     func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard case let cell as DemoCell = cell else {
//            return
//        }
//
//        cell.backgroundColor = .clear
//
//        if cellHeights[indexPath.row] == kCloseCellHeight {
//            cell.unfold(false, animated: false, completion: nil)
//        } else {
//            cell.unfold(true, animated: false, completion: nil)
//        }
//
//        cell.number = indexPath.row
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //as! FoldingCell
     //   let durations: [TimeInterval] = [0.26, 0.2, 0.2]
    //    cell.durationsForExpandedState = durations
    //    cell.durationsForCollapsedState = durations
        return cell
    }
    
   
    /*
 override   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    */
}




