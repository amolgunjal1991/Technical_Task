//
//  UIFontExtension.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 02/08/21.
//

import UIKit

extension UIFont {
    
    static func smallLabelFont() -> UIFont {
        let font = UIFont(name: FontConstants.helveticaBold, size: 13)
        return font ?? UIFont.systemFont(ofSize: 13)
    }
    
    static func mediumLabelFont() -> UIFont {
        let font = UIFont(name: FontConstants.helveticaBold, size: 15)
        return font ?? UIFont.systemFont(ofSize: 15)
    }
    
    static func filterLabelFont() -> UIFont {
        return UIFont(name: FontConstants.helveticaBold, size: 18) ?? UIFont.systemFont(ofSize: 18)
    }
    
    static func bulletPointFont() -> UIFont {
        return UIFont(name: FontConstants.helveticaBold, size: 35) ?? UIFont.systemFont(ofSize: 35)
    }
}
