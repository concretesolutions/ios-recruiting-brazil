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
  
  lazy var shadowView: UIImageView = {
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
  
  lazy var favoriteButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setBackgroundImage(UIImage(named: "unfavorite"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  lazy var containerView: UIStackView = {
    let view = UIStackView(frame: .zero)
    view.axis = .horizontal
    view.distribution = .fill
    view.spacing = 0
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
    addSubview(shadowView)
    addSubview(activityIndicator)
    addSubview(containerView)
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
    
    shadowView.snp.makeConstraints { make in
      make.height.equalTo(80)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    
    let width: CGFloat = 50.0
    favoriteButton.snp.makeConstraints { make in
      make.size.equalTo(CGSize(width: width, height: width))
    }
    
    let spacing: CGFloat = -2.5
    containerView.snp.makeConstraints { make in
      make.height.equalTo(width)
      make.leading.equalTo(-4*spacing)
      make.trailing.equalTo(spacing)
      make.bottom.lessThanOrEqualTo(2*spacing)
    }
  }
  
  func configureViews() {
    containerView.addArrangedSubview(titleLabel)
    containerView.addArrangedSubview(favoriteButton)
  }
}
