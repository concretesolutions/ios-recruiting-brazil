//
//  Result.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(T)
    case error(Error)
}
