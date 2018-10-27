//
//  Result.swift
//  Mov
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


enum Result<T> {
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case let .success(value) = self {
            return value
        } else {
            return nil
        }
    }
    
    func map<U>(_ transform: (T) throws -> (U)) rethrows -> Result<U> {
        switch self {
        case .success(let value):
            return Result<U>.success(try transform(value))
        case .failure(let error):
            return Result<U>.failure(error)
        }
    }
}

