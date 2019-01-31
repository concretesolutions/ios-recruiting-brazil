//
//  Array+Merge.swift
//  Movs
//
//  Created by Brendoon Ryos on 27/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
  public mutating func mergeElements<C : Collection>(newElements: C) where C.Iterator.Element == Element{
    let filteredList = newElements.filter({!self.contains($0)})
    self.append(contentsOf: filteredList)
  }
}
