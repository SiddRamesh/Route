//  Created by Ramesh Siddanavar on 14/03/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit

public class DemoTableViewController: PTTableViewController {

    fileprivate let items = [("1", "River cruise"), ("2", "North Island"), ("3", "Mountain Trail"), ("4", "Southern Coast"), ("5", "Fishing Place")] // image names
}

// MARK: UITableViewDelegate

extension DemoTableViewController {

    public override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    public override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ParallaxCell else { return }

        let index = indexPath.row % items.count
        let imageName = items[index].0
        let title = items[index].1

        if let image = UIImage(named: imageName) {
            cell.setImage(image, title: title)
        }
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ParallaxCell = tableView.getReusableCellWithIdentifier(indexPath: indexPath)
        return cell
    }

    public override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let storyboard = UIStoryboard.storyboard(storyboard: .Main)
        let detaleViewController: DemoDetailViewController = storyboard.instantiateViewController()
        pushViewController(detaleViewController)
    }
}
