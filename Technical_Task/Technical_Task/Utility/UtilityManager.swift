//
//  UtilityManager.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 30/07/21.
//

import UIKit


class UtilityManager {
    
    static func createLabelDynamically(textTitle: String, fontSize: CGFloat, color: UIColor, width : CGFloat, heightOfStack : Double) -> (UILabel,Double) {
        
        let labelHeight = textTitle.height(constraintedWidth: width - 100, font: UIFont(name: FontConstants.HELVETICA_BOLD, size: fontSize)!)
        var heightOfStackView = heightOfStack
        heightOfStackView = heightOfStackView + Double(labelHeight + 10)
        let label = UILabel(frame: CGRect(x: 20, y: CGFloat(heightOfStackView - Double(labelHeight)), width: width - 70, height: labelHeight + 15))
        label.textColor = color
        let bulletSymbol = Constants.BULLET_POINT_STRING
        let range = (textTitle as NSString).range(of: bulletSymbol)
        let attributtedText = NSMutableAttributedString(string:textTitle)
        attributtedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orangeColor(), range: range)
        attributtedText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: FontConstants.HELVETICA_BOLD, size: 20)!, range: range)
        label.font = UIFont(name: FontConstants.HELVETICA_BOLD, size: fontSize)
        
        label.attributedText = attributtedText
        label.numberOfLines = 0
        let finalLabelHeight = Double(labelHeight + 10)
        return (label,finalLabelHeight)
    }
    
}
