//
//  Commoms.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

enum ViewState {
  case normal
  case loading
  case searching(hasResult: Bool)
  case filter(hasResult: Bool)
  case error
}

enum Result<Value> {
  case success(Value)
  case error(String)
}
