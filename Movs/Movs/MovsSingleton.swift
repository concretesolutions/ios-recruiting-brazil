//
//  MovsSingleton.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

class MovsSingleton {
  
  static let shared = MovsSingleton()
  
  var globalSettings: Settings?
  
  private init() {}
  
}
