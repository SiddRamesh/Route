//  Created by Ramesh Siddanavar on 14/03/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//
import Foundation
import UIKit

extension UIImage {
    enum Asset: String {
        case _1 = "1"
        case _2 = "2"
        case _3 = "3"
        case _4 = "4"
        case _5 = "5"
        case Back = "back"
        case HertIcon
        case PlusIcon
        case ShareIcon
        case TransparentPixel

        var image: UIImage {
            return UIImage(asset: self)
        }
    }

    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
