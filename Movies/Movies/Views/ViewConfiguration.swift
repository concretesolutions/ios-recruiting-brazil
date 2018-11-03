//
//  ViewConfiguration.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 03/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Foundation

protocol ViewConfiguration: class {
  func setupConstraints()
  func buildViewHierarchy()
  func configureViews()
  func setupViewConfiguration()
}

extension ViewConfiguration {
  
  func setupViewConfiguration() {
    buildViewHierarchy()
    setupConstraints()
    configureViews()
  }
  
  func configureViews() {
  }
  
}
