//
//  GenericListParams.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

enum GenericListParamsType {
  case dates
  case genres
}

struct GenericListParams {
  
  var type: GenericListParamsType = .dates
  var title: String = ""
  var items: [String] = []
  var selectedYear: String? = nil
  var selectedGenres: [Int]? = nil
  
  init(type: GenericListParamsType, title: String, items: [String], selectedYear: String) {
    self.type = type
    self.title = title
    self.items = items
    self.selectedYear = selectedYear
  }
  
  init(type: GenericListParamsType, title: String, items: [String], selectedGenres: [Int]) {
    self.type = type
    self.title = title
    self.items = items
    self.selectedGenres = selectedGenres
  }
  
}
