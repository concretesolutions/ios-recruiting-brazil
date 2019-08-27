//
//  TMViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit
import MBProgressHUD

class TMViewController: UIViewController {
  
  func showHud(_ message: String) {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.label.text = message
    hud.isUserInteractionEnabled = false
  }

  func hideHud() {
    MBProgressHUD.hide(for: self.view, animated: true)
  }

  func showAlert(title: String, message: String, action: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
    
    self.present(alert, animated: true)
  }
 
}
