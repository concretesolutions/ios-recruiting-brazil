//
//  UIViewControllerExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(message: String) {
        let okAction = UIAlertAction(title: "Entendi", style: .cancel, handler: nil)
        self.showAlert(title: "Ops, algo deu errado!", message: message, actions: [okAction])
    }

    func showError(message: String, handler: @escaping () -> Void) {
        
            let okAction = UIAlertAction(title: "Entendi", style: .cancel) { _ in
                handler()
            }
            self.showAlert(title: "Ops, algo deu errado!", message: message, actions: [okAction])
        
    }
    
    func showAlert(title: String = "Atenção", message: String) {
        let okAction = UIAlertAction(title: "Entendi", style: .cancel, handler: nil)
        self.showAlert(title: title, message: message, actions: [okAction])
    }

    func showAlert(title: String = "Atenção", message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0.5764705882, blue: 0.6352941176, alpha: 1)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
