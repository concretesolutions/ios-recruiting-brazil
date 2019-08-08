//
//  Bundle+extensions.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

extension Bundle {
  
  var kBaseURL: String {
    return object(forInfoDictionaryKey: "kBaseURL") as? String ?? ""
  }
  
}
