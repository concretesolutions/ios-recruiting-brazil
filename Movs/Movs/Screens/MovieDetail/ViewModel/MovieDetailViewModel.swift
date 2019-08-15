//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 14/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
  
  var dataSource: MovieDetailDatasource!
  
  // MARK: - Life cycle
  
  init(with datasource: MovieDetailDatasource) {
    self.dataSource = datasource
  }
  
  // MARK: - Public methods
  
}
