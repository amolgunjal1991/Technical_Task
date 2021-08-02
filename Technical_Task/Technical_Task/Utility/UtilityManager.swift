//
//  UtilityManager.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 30/07/21.
//

import UIKit


class UtilityManager {
    //MARK: create dynamic UILabel with bullet point
    /**
     - Parameters:
     - textTitle:Title for the Label
     - fontSize: Font size for the UILabel
     - color: Color  for the UILabel text
     - heightOfStack : Height of stack view to maintain the cell height
     */
    static func createLabelDynamically(textTitle: String,
                                       fontSize: CGFloat,
                                       color: UIColor,
                                       width : CGFloat,
                                       heightOfStack : Double) -> (UILabel,Double) {
        let labelHeight = textTitle.height(constraintedWidth: width - 100, font: UIFont(name: FontConstants.helveticaBold, size: fontSize)!)
        var heightOfStackView = heightOfStack
        heightOfStackView = heightOfStackView + Double(labelHeight + 10)
        let label = UILabel(frame: CGRect(x: 20,
                                          y: CGFloat(heightOfStackView - Double(labelHeight)),
                                          width: width - 50,
                                          height: labelHeight))
        label.textColor = color
        label.text = textTitle
        label.font = UIFont.mediumLabelFont()
        label.numberOfLines = 0
        label.sizeToFit()
        label.baselineAdjustment = .alignBaselines
        label.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        return (label,heightOfStackView)
    }
    
    //MARK: create dynamic UIstackview with horizontal labels with bullet point
    /**
     - Parameters:
     - textTitle:Title for the Label
     - fontSize: Font size for the UILabel
     - color: Color  for the UILabel text
     - heightOfStack : Height of stack view to maintain the cell height
     - returns
     - UIstackview: stackview with two labes including bullet point
     - heightOfStack : Height of stack view to maintain the cell height
     */
    static func createStackViewOfBulletLabel(textTitle: String,
                                             fontSize: CGFloat,
                                             color: UIColor,
                                             width : CGFloat,
                                             heightOfStack : Double) -> (UIStackView,Double) {
        let labelHeight = textTitle.height(constraintedWidth: width - 100,
                                           font: UIFont(name: FontConstants.helveticaBold, size: fontSize)!)
        var heightOfStackView = heightOfStack
        heightOfStackView = heightOfStackView + Double(labelHeight + 10)
        
        // Create bullet label
        let bulletLabel = UILabel(frame: CGRect(x: 20,
                                                y: CGFloat(heightOfStackView - Double(labelHeight)),
                                                width: 20,
                                                height: 15))
        let attributtedText = NSMutableAttributedString(string:Constants.bulletPointString)
        let bulletSymbol = Constants.bulletPointString
        let range = (bulletSymbol as NSString).range(of: bulletSymbol)
        attributtedText.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.orangeColor(),
                                     range: range)
        attributtedText.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont.bulletPointFont(),
                                     range: range)
        bulletLabel.attributedText = attributtedText
        
        // Create text label
        let label = UILabel(frame: CGRect(x: 40,
                                          y: CGFloat(heightOfStackView - Double(labelHeight)),
                                          width: width - 70,
                                          height: labelHeight))
        label.textColor = color
        label.font = UIFont(name: FontConstants.helveticaBold, size: fontSize)
        label.text = textTitle
        label.numberOfLines = 0
        label.baselineAdjustment = .alignBaselines
        label.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        
        // Create horizontal stack view to add bullet labes
        let labelConstainerStack = UIStackView()
        labelConstainerStack.axis = .horizontal
        labelConstainerStack.alignment = .fill
        labelConstainerStack.distribution = .fill
        labelConstainerStack.setCustomSpacing(40, after: bulletLabel)
        labelConstainerStack.addSubview(bulletLabel)
        labelConstainerStack.addSubview(label)
        return (labelConstainerStack,heightOfStackView)
    }
}
