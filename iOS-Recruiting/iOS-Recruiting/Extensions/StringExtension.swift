//
//  StringExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation

extension Int {
    
    init(_ bool:Bool) {
        self = bool ? 1 : 0
    }
    
    func isInternetErrorCode() -> Bool {
        return [0, -1001, 408, -1009].contains(self)
    }
    
    func isSuccessCode() -> Bool {
        return (200...299).contains(self)
    }
    
}
