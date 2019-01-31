//
//  ErrorView.swift
//  Movs
//
//  Created by Brendoon Ryos on 28/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

enum ErrorType {
  case search(query: String)
  case server
  case none
  
  var description: String {
    switch self {
    case .search:
      return "search"
    case .server:
      return "server"
    default:
      return ""
    }
  }
}

class ErrorView: UIView {
  lazy var messageLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  lazy var iconImageView: UIImageView = {
    let view = UIImageView(frame: .zero)
    view.contentMode = .scaleAspectFit
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with errorType: ErrorType) {
    alpha = 1
    iconImageView.image = UIImage(named: errorType.description)
    switch errorType {
    case .search(let query):
      messageLabel.text = "Your search for \"\(query)\" found no results."
    case .server:
      messageLabel.text = "An error occurred. Please, try again."
    default:
      alpha = 0
      messageLabel.text = nil
    }
  }
}

extension ErrorView: ViewCode {
  func buildViewHierarchy() {
    addSubview(iconImageView)
    addSubview(messageLabel)
  }
  
  func setupConstraints() {
    
    let height = 160
    let top = 180
    iconImageView.snp.makeConstraints { make in
      make.top.equalTo(top)
      make.size.equalTo(CGSize(width: height, height: height))
      make.centerX.equalToSuperview()
    }
    
    messageLabel.snp.makeConstraints { make in
      let spacing = 30
      make.leading.equalTo(spacing)
      make.trailing.equalTo(-spacing)
      make.top.equalTo(height + top + spacing)
    }
  }
  
  func configureViews() {
    setup(with: .none)
  }
}
