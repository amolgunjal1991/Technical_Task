//
//  BaseViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 30/07/21.
//

import UIKit

class BaseViewController : UIViewController {
    
    // MARK: Set title to the left of navigation bar
    /**
     - Parameters:
     - title : Title string for the navigation bar
     - textColor : Pass te uicolor for the text of the navigation bar
     */
    func setupNavigationBar(title:String,textColor:UIColor) {
        if let navigationBar = self.navigationController?.navigationBar {
            let letfNavigationBarTitle = CGRect(x: 20,
                                                y: 0,
                                                width: navigationBar.frame.width/2,
                                                height: navigationBar.frame.height)
            let titleLabel = UILabel(frame: letfNavigationBarTitle)
            titleLabel.textColor = textColor
            titleLabel.text = title
            navigationBar.addSubview(titleLabel)
        }
    }
    
    // MARK: Add shadow to the textfield collections
    /**
     - Parameters:
     - textFields : Array of textfields which will used for setting the shadow for the collection of textfields
     */
    func addShadowToTextfield(textFields: [UITextField]) {
        for textField in textFields {
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            textField.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
            textField.layer.shadowOpacity = 0.4
            textField.layer.shadowRadius = 1.0
            textField.layer.shadowOffset = CGSize(width: 0, height: 3)
            textField.layer.shadowColor = UIColor.black.cgColor
        }
    }
}

