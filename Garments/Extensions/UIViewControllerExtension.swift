//
//  UIViewControllerExtension.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(error: Error) {
        alert(title: "", msg: error.localizedDescription, buttons: [Alert.Button.ok], handler: nil)
    }
    
    func alert(error: String) {
        alert(title: "", msg: error, buttons: [Alert.Button.ok], handler: nil)
    }
    
    func alert(title: String? = nil, msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        if self.presentedViewController == nil {
            let alert = UIAlertController(title: title?.localized, message: msg.localized, preferredStyle: .alert)
            for button in buttons {
                let action = UIAlertAction(title: button.localized, style: .cancel, handler: { action in
                    handler?(action)
                })
                alert.addAction(action)
            }
            present(alert, animated: true, completion: nil)
        }
    }
}
