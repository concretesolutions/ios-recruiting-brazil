//
//  MovieCollectionReusableView.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class MovieCollectionReusableView: UICollectionReusableView {
  
  static func height() -> CGFloat {
    return 60
  }
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .whiteLarge)
    view.color = ColorPalette.black
    
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MovieCollectionReusableView: ViewCode {
  func buildViewHierarchy() {
    addSubview(activityIndicator)
  }
  func setupConstraints() {
    activityIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
