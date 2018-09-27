//
//  ViewControllerExtension.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 26/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
