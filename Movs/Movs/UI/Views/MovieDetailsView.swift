//
//  MovieDetailsView.swift
//  Movs
//
//  Created by Brendoon Ryos on 31/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import SnapKit

class MovieDetailsView: UIView {
  
  lazy var gridView: MovieGridView = {
    let view = MovieGridView(frame: .zero)
    view.backgroundColor = .gray
    return view
  }()
  
  lazy var yearLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  lazy var genresLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  lazy var overviewLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.numberOfLines = 20
    label.font = UIFont.systemFont(ofSize: 18)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.2
    return label
  }()
  
  lazy var containerView: UIStackView = {
    let view = UIStackView(frame: .zero)
    view.axis = .vertical
    view.distribution = .fillProportionally
    view.spacing = 15
    return view
  }()

  lazy var closeButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(named: "close"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with viewModel: Movies.Details.ViewModel) {
    if let backdropPath = viewModel.backdropPath {
      gridView.imageView.download(image: backdropPath, activityIndicator: gridView.activityIndicator)
    } else {
      gridView.imageView.image = UIImage(named: "noBackdrop")
    }
    
    gridView.titleLabel.text = viewModel.title
    yearLabel.text = viewModel.year
    genresLabel.text = viewModel.genresString
    overviewLabel.text = viewModel.overview
  }
}


extension MovieDetailsView: ViewCode {
  func buildViewHierarchy() {
    addSubview(gridView)
    addSubview(containerView)
    addSubview(closeButton)
  }
  
  func setupConstraints() {
    let height = UIScreen.main.bounds.height/3
    gridView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.equalTo(height)
    }
    
    let spacing: CGFloat = 10
    containerView.snp.makeConstraints { make in
      make.leading.equalTo(spacing)
      make.trailing.equalTo(-spacing)
      make.top.equalTo(height + spacing)
      make.bottom.lessThanOrEqualTo(-spacing)
    }
    
    let buttonWidth = 30
    closeButton.snp.makeConstraints { make in
      make.size.equalTo(CGSize(width: buttonWidth, height: buttonWidth))
      make.top.equalTo(2*spacing)
      make.leading.equalTo(spacing)
    }
  }
  
  func configureViews() {
    gridView.titleLabel.font = UIFont.systemFont(ofSize: 24)
    containerView.addArrangedSubview(yearLabel)
    containerView.addArrangedSubview(genresLabel)
    containerView.addArrangedSubview(overviewLabel)
  }
}
