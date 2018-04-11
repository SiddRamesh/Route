//
//  Created by Ramesh Siddanavar on 3/21/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//


import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultsTableView: UITableView!
   
    var Mcity:String = ""
    var Msub:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. juhu
        DispatchQueue.main.async {
        self.searchCompleter.delegate = self
        }
    }
    
    func highlightedText(_ text: String, inRanges ranges: [NSValue], size: CGFloat) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        let regular = UIFont.systemFont(ofSize: size)
        attributedText.addAttribute(NSAttributedStringKey.font, value:regular, range:NSMakeRange(0, text.count))
        
        let bold = UIFont.boldSystemFont(ofSize: size)
        for value in ranges {
            attributedText.addAttribute(NSAttributedStringKey.font, value:bold, range:value.rangeValue)
        }
        return attributedText
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
        self.searchCompleter.queryFragment = searchText
        }
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    
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

extension SearchViewController: UITableViewDataSource {
    
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
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let city = response?.mapItems[0].placemark.subAdministrativeArea //   coordinate
            let sub = response?.mapItems[0].placemark.administrativeArea
            print(sub! + city!)
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let navViewController = storyboard.instantiateViewController(withIdentifier: "AddTrip")
                self.present(navViewController, animated: true)
                self.Mcity = sub!
                self.Msub = city!
            }
        }
    }
}
