//
//  ViewControllerExtension.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 31/07/21.
//

import UIKit


extension UIViewController {

func showToast(message : String, duration: Double) {

    let toastLabel = UILabel(frame: CGRect(x: 50, y: self.view.frame.size.height-70, width: self.view.frame.width - 100, height: 40))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = UIFont(name: FontConstants.HELVETICA_BOLD, size: 15.0)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
}
