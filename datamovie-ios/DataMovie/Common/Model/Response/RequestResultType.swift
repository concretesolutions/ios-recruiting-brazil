//
//  RequestResultType.swift
//  DataMovie
//
//  Created by Andre on 25/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum RequestResultType<T> {
    case success(T)
    case failure(ErrorResponse)
}
