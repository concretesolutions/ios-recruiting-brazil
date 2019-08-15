//
//  BaseViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

typealias AlertCallback = (() -> Void)

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTitleNavigationBar()
  }
  
  // MARK: - Customization methods
  
  internal func configureTitleNavigationBar(_ titleColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
    guard let navigationController = self.navigationController else { return }

    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .medium), .foregroundColor: titleColor]

    navigationController.navigationBar.titleTextAttributes = attributes
  }
  
  internal func configureNavigationBar(tintColor navigationBarTintColor: UIColor, barColor navigationBarBackgroundColor: UIColor, translucent: Bool = false, removeShadow: Bool = true) {
    guard let navigationController = self.navigationController else { return }
    
    navigationController.navigationBar.tintColor = navigationBarTintColor
    navigationController.navigationBar.barTintColor = navigationBarBackgroundColor
    navigationController.navigationBar.isTranslucent = translucent

    if removeShadow {
      navigationController.navigationBar.shadowImage = UIImage()
      navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)

    }
  }
  
  fileprivate func makeAttributedPlaceHolder(with placeholder: String, and color: UIColor) -> NSAttributedString {
    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .semibold), .foregroundColor: color]

    let attributedString = NSAttributedString(string: placeholder, attributes: attributes)
    
    return attributedString
  }
  
  func configureSearchField(in searchBar: UISearchBar, with backgroundColor: UIColor, and tintColor: UIColor) {
    guard let searchField = searchBar.value(forKey: "_searchField") as? UITextField else { return }

    searchField.clearButtonMode = .whileEditing
    searchField.roundedCorners(10)
    searchField.backgroundColor = backgroundColor
    searchField.textColor = tintColor
    searchField.attributedPlaceholder = self.makeAttributedPlaceHolder(with: "search".localized(), and: tintColor)

    // Search Icon
    guard let searchIcon = searchField.leftView as? UIImageView else { return }

    searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
    searchIcon.tintColor = tintColor
    
    // Clear Button
    guard let clearButton = searchField.value(forKey: "clearButton") as? UIButton else { return }
    
    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    clearButton.tintColor = tintColor

    // Adjustment offsets
    searchBar.centeredPlaceHolder()
  }
  
  // MARK: - Navigation
  
  func addRightBarButtonItem(with icon: UIImage, iconTintColor: UIColor? = nil, target: Any?, action: Selector?) {
    let customButton = UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
    
    if let tintColor = iconTintColor {
      customButton.tintColor = tintColor
    }

    self.navigationItem.rightBarButtonItem = customButton
  }
  
  func showErrorMessage(_ message: String, withTryAgainButton: Bool = true, tryAgainCallback: AlertCallback? = nil) {
    let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)

    let closeAction = UIAlertAction(title: "close".localized(), style: .cancel, handler: nil)
    
    alert.addAction(closeAction)
    
    if withTryAgainButton {
      let tryAgainAction = UIAlertAction(title: "try-again".localized(), style: .default) { _ in
        guard let handler = tryAgainCallback else { return }
        handler()
      }
      
      
      alert.addAction(tryAgainAction)
    }

    self.present(alert, animated: true, completion: nil)
  }

}
