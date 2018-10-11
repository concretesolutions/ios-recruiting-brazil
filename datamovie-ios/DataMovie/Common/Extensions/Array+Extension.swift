//
//  Array+Extension.swift
//  DataMovie
//
//  Created by Andre on 23/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
