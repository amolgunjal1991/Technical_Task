//
//  IntegerExtension.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 01/08/21.
//

import UIKit

extension Int {
    // MARK: Provide formatted price string from the input integer value
    /**
     - Parameters:
     - returns : String with required format fo price
     */
    func convertPriceIntoThousand() -> Int {
        return self/1000
    }
}
