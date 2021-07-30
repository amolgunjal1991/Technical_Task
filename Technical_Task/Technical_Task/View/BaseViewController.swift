//
//  BaseViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 30/07/21.
//

import UIKit

class BaseViewController : UIViewController {
    
    //MARK: Set title to the left of navigation bar
        /**
          - Parameters:
            - title : Title string for the navigation bar
            - textColor : Pass te uicolor for the text of the navigation bar
         */
        func setupNavigationBar(title:String,textColor:UIColor){
            if let navigationBar = self.navigationController?.navigationBar {
                let letfNavigationBarTitle = CGRect(x: 20, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
                let titleLabel = UILabel(frame: letfNavigationBarTitle)
                titleLabel.textColor = textColor
                titleLabel.text = title
                navigationBar.addSubview(titleLabel)
            }
        }
    
}
