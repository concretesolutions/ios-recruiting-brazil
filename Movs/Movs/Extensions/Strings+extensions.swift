//
//  Strings+extensions.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

extension String {
  
  func localized() -> String {
    return NSLocalizedString(self, comment: "")
  }
  
  func toDate() -> Date {
    return Date()
  }

}
