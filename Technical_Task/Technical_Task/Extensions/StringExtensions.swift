//
//  StringExtensions.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 29/07/21.
//

import UIKit

extension String {
    //MARK: Calculate height for the label as per contents
        /**
          - Parameters:
            - width : Width of the label
            - font : Font size for the label
         */
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width - 2, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()

        return label.frame.height
     }
    
}
