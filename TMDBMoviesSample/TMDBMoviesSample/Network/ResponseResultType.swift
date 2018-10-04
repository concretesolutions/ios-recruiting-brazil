//
//  ResponseResultType.swift
//  IMDBUpcomingMoviesSample
//
//  Created by Breno Rage Aboud on 19/07/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

public enum ResponseResultType<T> {
    case success(T)
    case fail(Error)
}
