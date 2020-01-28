//
//  UIViewController+extension.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 26/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//
import UIKit

extension UIViewController {
    
    public func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func touchScreenHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
