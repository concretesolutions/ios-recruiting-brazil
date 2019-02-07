//
//  FilterMoviesView.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FilterMoviesView: UIView {
  
  lazy var tableView: FilterMoviesTableView = {
    let view  = FilterMoviesTableView()
    view.isScrollEnabled = false
    view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    view.tableFooterView = UIView()
    view.backgroundColor = .clear
    return view
  }()
  
  lazy var applyButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setTitle("Apply", for: .normal)
    button.titleLabel?.font = UIFont(name: FontNames.bold, size: 18)
    button.backgroundColor = .gray
    button.setTitleColor(ColorPalette.black, for: .normal)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension FilterMoviesView: ViewCode {
  func buildViewHierarchy() {
    addSubview(tableView)
    addSubview(applyButton)
  }
  
  func setupConstraints() {
    let height = 470
    tableView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.top.equalToSuperview()
      make.height.equalTo(height)
    }
    
    let spacing = 15
    applyButton.snp.makeConstraints { make in
      make.leading.equalTo(spacing)
      make.trailing.equalTo(-spacing)
      make.top.equalTo(height + 4*spacing)
      make.height.equalTo(3*spacing)
    }
  }
  
  func configureViews() {
    backgroundColor = ColorPalette.white
    applyButton.addShadow()
  }
}
