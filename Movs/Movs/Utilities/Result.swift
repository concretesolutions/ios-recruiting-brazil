//
//  Result.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
