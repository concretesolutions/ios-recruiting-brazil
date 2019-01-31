//
//  MovieGridView.swift
//  Movs
//
//  Created by Brendoon Ryos on 26/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class MovieGridView: UIView {
  lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .whiteLarge)
    return view
  }()

  lazy var imageView: UIImageView = {
    let view = UIImageView(frame: .zero)
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  lazy var containerView: UIImageView = {
    let view = UIImageView(frame: .zero)
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.image = UIImage(named: "container")
    return view
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textColor = ColorPalette.white
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.2
    label.numberOfLines = 3
    return label
  }()
  
  lazy var favoriteImageView: UIImageView = {
    let view = UIImageView(frame: .zero)
    view.image = UIImage(named: "unfavorite")
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
}

extension MovieGridView: ViewCode {
  func buildViewHierarchy() {
    addSubview(imageView)
    addSubview(containerView)
    addSubview(activityIndicator)
    containerView.addSubview(favoriteImageView)
    containerView.addSubview(titleLabel)
  }
  
  func setupConstraints() {
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }
    
    activityIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    containerView.snp.makeConstraints { make in
      make.height.equalTo(80)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    let width: CGFloat = 45.0
    let spacing: CGFloat = -2.5
    favoriteImageView.snp.makeConstraints { make in
      make.size.equalTo(CGSize(width: width, height: width))
      make.trailing.equalTo(spacing)
      make.bottom.equalTo(spacing)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.centerY.lessThanOrEqualTo(self.favoriteImageView)
      make.bottom.equalTo(spacing)
      make.leading.equalTo(-2*spacing)
      make.trailing.equalTo(spacing - width)
    }
  }
}
