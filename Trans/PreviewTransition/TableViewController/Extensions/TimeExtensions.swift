//  Created by Ramesh Siddanavar on 14/03/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import Foundation

func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
