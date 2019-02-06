//
//  FavoriteMoviesView.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteMoviesView: UIView {
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .whiteLarge)
    view.color = ColorPalette.black
    view.backgroundColor = ColorPalette.black.withAlphaComponent(0.2)
    return view
  }()
  
  lazy var tableView: FavoriteMoviesTableView = {
    let view = FavoriteMoviesTableView()
    view.separatorStyle = .none
    view.backgroundColor = .clear
    return view
  }()
  
  lazy var errorView: ErrorView = {
    let view = ErrorView(frame: .zero)
    view.alpha = 0
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

extension FavoriteMoviesView: ViewCode {
  func buildViewHierarchy() {
    addSubview(tableView)
    addSubview(errorView)
    addSubview(activityIndicator)
  }
  
  func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    errorView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    activityIndicator.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func configureViews() {
    backgroundColor = ColorPalette.white
  }
}
