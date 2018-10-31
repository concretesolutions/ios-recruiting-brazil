//
//  ErrorView.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class ErrorView: UIView {
  var errorMessageLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 16, weight: .light)
    label.textAlignment = .center
    label.numberOfLines = 2
    return label
  }()
  
  var tryAgainButton: UIButton = {
    let button = UIButton(type: .system)
    button.frame = CGRect(x: 0, y: 0, width: 76, height: 20)
    button.setTitleColor(.orangePizazz, for: .normal)
    button.setTitle("Try Again", for: .normal)
    button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
    return button
  }()
  
  var tryAgainButtonHandler: () -> Void
  
  init(defaultErrorMessage: String = "Oops! Something went wrong.", tryAgainButtonHandler: @escaping () -> Void) {
    self.tryAgainButtonHandler = tryAgainButtonHandler
    super.init(frame: CGRect.zero)
    frame = CGRect(x: 0, y: 0, width: 150, height: 90)
    errorMessageLabel.text = defaultErrorMessage
    positionFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func positionFrames() {
    addSubview(errorMessageLabel)
    addSubview(tryAgainButton)
    
    errorMessageLabel.frame.origin.x = center.x - errorMessageLabel.frame.width / 2
    errorMessageLabel.frame.origin.y = center.y - errorMessageLabel.frame.height / 2 - 25
    tryAgainButton.frame.origin.x = center.x - tryAgainButton.frame.width / 2
    tryAgainButton.frame.origin.y = errorMessageLabel.frame.maxY + 16
  }
  
  @objc func tryAgainButtonTapped() {
    tryAgainButtonHandler()
  }
}
