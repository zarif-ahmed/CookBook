//
//  UIViewController+Extension.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil,
                   message: String,
                   firstActionTitle: String,
                   firstActionCallback: ((UIAlertAction) -> Void)? = nil,
                   secondActionTitle: String? = nil,
                   secondActionCallback: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action1 = UIAlertAction(title: firstActionTitle,
                                    style: .default,
                                    handler: firstActionCallback)
        alert.addAction(action1)
        
        if let secondAction = secondActionTitle {
            let action2 = UIAlertAction(title: secondAction,
                                        style: .default,
                                        handler: secondActionCallback)
            alert.addAction(action2)
        }
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func showNoInternetAlert() {
        showAlert(title: "No Internet", message: "Please check your internet connection and try again.", firstActionTitle: "OK")
    }
}
