//
//  TextFieldExtension.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 01/08/21.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ paddingBy:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingBy, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ paddingBy:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingBy, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
