//
//  MovieListViewController+DismissKeyboard.swift
//  Movs
//
//  Created by Ricardo Rachaus on 31/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

extension MovieListViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
