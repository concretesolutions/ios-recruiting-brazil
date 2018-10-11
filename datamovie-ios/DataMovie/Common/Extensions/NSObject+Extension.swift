//
//  NSObject+Extension.swift
//  RateX
//
//  Created by Andre Souza on 04/07/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

protocol DescribeProtocol: class { }

extension DescribeProtocol where Self: NSObject {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension NSObject: DescribeProtocol { }
