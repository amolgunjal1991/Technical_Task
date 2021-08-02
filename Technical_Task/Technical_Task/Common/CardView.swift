//
//  CardView.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 30/07/21.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.3
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds,
                                      cornerRadius: cornerRadius)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth,
                                    height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
