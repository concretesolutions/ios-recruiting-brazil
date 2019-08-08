//
//  SecurityManager.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

class SecurityManager: NSObject {
  
  static let shared = SecurityManager()
  
  fileprivate let obfuscator = Obfuscator()
  
  override internal init() {}
  
  func reveal(_ key: [UInt8]) -> String {
    return obfuscator.reveal(key: key)
  }
  
}
