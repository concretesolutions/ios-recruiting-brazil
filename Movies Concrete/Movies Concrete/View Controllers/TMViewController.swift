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
  
  let customView = UIView()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
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
  
  func showErrorMessage(text: String) {
    customView.frame = CGRect.init(x: 0, y: 0, width: 500, height: 510)
    customView.backgroundColor = Colors.colorBackground   
    customView.center = self.view.center
    self.view.addSubview(customView)
    
    let imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 80, height: 80))
    imageView.image = UIImage(named:"sad")
    imageView.center = CGPoint(x: 250, y: 90)
    self.customView.addSubview(imageView)
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
    label.center = CGPoint(x: 250, y: 150)
    label.textAlignment = .center
    label.textColor = UIColor.white
    label.text = text
    self.customView.addSubview(label)
  }
  
  func hideErrorMessage() {
    self.customView.removeFromSuperview()
  }
}
