//
//  UIViewController+CustomAlert.swift
//  Movs
//
//  Created by Adann Simões on 19/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

extension UIViewController {
    func customAlert(title: String, message: String, actionTitle: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
            let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: false)
        }
    }
}
