//
//  FavoriteMovieTableViewCell.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import Reusable

class FavoriteMovieTableViewCell: UITableViewCell, Reusable {
  
  static func height() -> CGFloat {
    return 182
  }
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .whiteLarge)
    return view
  }()
  
  lazy var background: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = ColorPalette.white
    return view
  }()
  
  lazy var posterImageView: UIImageView = {
    let view = UIImageView(frame: .zero)
    view.backgroundColor = .gray
    view.contentMode = .scaleAspectFit
    view.clipsToBounds = true
    return view
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont(name: FontNames.medium, size: 20)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.2
    label.numberOfLines = 3
    return label
  }()
  
  lazy var yearLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont(name: FontNames.regular, size: 20)
    label.textAlignment = .right
    return label
  }()
  
  lazy var overviewLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont(name: FontNames.light, size: 17)
    label.numberOfLines = 4
    label.textColor = .darkGray
    return label
  }()
  
  lazy var topContainerView: UIStackView = {
    let view = UIStackView(frame: .zero)
    view.axis = .horizontal
    view.spacing = 10
    view.distribution = .fill
    return view
  }()
  
  lazy var containerView: UIStackView = {
    let view = UIStackView(frame: .zero)
    view.axis = .vertical
    view.distribution = .fill
    view.spacing = 5
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with item: CDMovie) {
    if item.posterPath != .none {
      posterImageView.download(image: item.posterPath, activityIndicator: activityIndicator)
    } else {
      posterImageView.image = UIImage(named: "noPoster")
    }
    titleLabel.text = item.title
    let dateComponets = item.releaseDate?.components(separatedBy: "-")
    yearLabel.text = dateComponets?.first
    overviewLabel.text = item.overview
  }
}

extension FavoriteMovieTableViewCell: ViewCode {
  func buildViewHierarchy() {
    addSubview(background)
    background.addSubview(posterImageView)
    posterImageView.addSubview(activityIndicator)
    background.addSubview(containerView)
  }
  
  func setupConstraints() {
    var spacing: CGFloat = 15
    background.snp.makeConstraints { make in
      make.leading.equalTo(spacing)
      make.trailing.equalTo(-spacing)
      make.top.equalTo(spacing/2)
      make.bottom.equalTo(-spacing/2)
    }
    
    let width = (FavoriteMovieTableViewCell.height() - spacing) * (2/3)
    posterImageView.snp.makeConstraints { make in
      make.width.equalTo(width)
      make.leading.equalToSuperview()
      make.bottom.equalToSuperview()
      make.top.equalToSuperview()
    }
    
    activityIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    let height = 50
    yearLabel.snp.makeConstraints { make in
      make.width.equalTo(height)
    }
    
    topContainerView.snp.makeConstraints { make in
      make.height.equalTo(height)
    }
    
    spacing = 10
    containerView.snp.makeConstraints { make in
      make.leading.equalTo(width + spacing)
      make.trailing.equalTo(-spacing)
      make.top.equalTo(spacing)
      make.bottom.lessThanOrEqualTo(-spacing)
    }
  }
  
  func configureViews() {
    selectionStyle = .none
    background.addShadow()
    topContainerView.addArrangedSubview(titleLabel)
    topContainerView.addArrangedSubview(yearLabel)
    containerView.addArrangedSubview(topContainerView)
    containerView.addArrangedSubview(overviewLabel)
  }
}


