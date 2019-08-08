//
//  BaseViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  var navigationBarTintColor: UIColor = .white {
    didSet {
      self.navigationController?.navigationBar.tintColor = navigationBarTintColor
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationBar()
  }
  
  // MARK: - Customization methods
  
  internal func configureNavigationBar(_ color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
//    guard let navigationController = self.navigationController else { return }
//
//    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "SF Compact Rounded", size: 20)!, .foregroundColor: color]
//
//    navigationController.navigationBar.titleTextAttributes = attributes
  }
  
  // MARK: - Navigation
  
  func addRightBarButtonItem(with target: Any?, action: Selector?) {
    let customButton = UIBarButtonItem(title: "Fechar", style: .plain, target: target, action: action)

    self.navigationItem.rightBarButtonItem = customButton
  }
  
}
