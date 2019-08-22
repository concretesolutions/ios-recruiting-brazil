//
//  Array+extensions.swift
//  Movs
//
//  Created by Marcos Lacerda on 22/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

extension Array {
  
  func containsElements(of items: [Int]) -> Bool {
    let filteredItems = self.filter { element -> Bool in
      if let item = element as? Int {
        return items.contains(item)
      }
      
      return false
    }
    
    return filteredItems.count > 0
  }
  
}
