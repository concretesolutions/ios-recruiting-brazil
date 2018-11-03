//
//  Enums.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 01/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

enum Result<Value> {
  case success(Value)
  case failure(Error)
}

enum FilterType {
  case genre
  case date
}

enum TypeError {
  case empty
  case unexpected
  case noError
  case noData
}
