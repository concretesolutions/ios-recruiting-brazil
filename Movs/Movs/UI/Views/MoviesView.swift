//
//  MoviesView.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import SnapKit

class MoviesView: UIView {
  lazy var middleactivityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .whiteLarge)
    view.color = ColorPalette.black
    view.backgroundColor = ColorPalette.black.withAlphaComponent(0.2)
    return view
  }()
  
  lazy var collectionView: MoviesCollectionView = {
    let view = MoviesCollectionView()
    view.decelerationRate = .fast
    view.backgroundColor = .clear
    return view
  }()
  
  lazy var errorView: ErrorView = {
    let view = ErrorView(frame: .zero)
    view.alpha = 0
    return view
  }()
  
  override init(frame: CGRect = UIScreen.main.bounds) {
    super.init(frame: frame)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MoviesView: ViewCode {
  func buildViewHierarchy() {
    addSubview(collectionView)
    addSubview(errorView)
    addSubview(middleactivityIndicator)
  }
  
  func setupConstraints() {
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    errorView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    middleactivityIndicator.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func configureViews() {
    backgroundColor = ColorPalette.white
  }
}
