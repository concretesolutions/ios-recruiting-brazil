//
//  Log.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation

class Log {

    static let shared = Log()
    
    internal var requests = [String]()
    internal var status = [Int]()
    internal var results = [String]()
    
    internal func show(info: Any) {
        print("💚 \(info)")
    }

    internal func show(error: Any) {
        print("❤️ \(error)")
    }

    internal func show(event: Any) {
        print("💙 \(event)")
    }
    
}
