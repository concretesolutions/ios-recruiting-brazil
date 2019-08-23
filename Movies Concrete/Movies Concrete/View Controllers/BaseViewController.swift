//
//  BaseViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  func showHud(_ message: String) {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.label.text = message
    hud.isUserInteractionEnabled = false
  }
  
  func hideHUD() {
    MBProgressHUD.hide(for: self.view, animated: true)
  }

}
