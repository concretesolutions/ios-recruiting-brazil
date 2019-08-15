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
  
  func toDate(_ pattern: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = pattern

    return dateFormatter.date(from: self) ?? Date()
  }

}
