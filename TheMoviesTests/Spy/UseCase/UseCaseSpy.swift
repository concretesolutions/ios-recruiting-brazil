//
//  UseCaseSpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
@testable import TheMovies

class UseCaseSpy<P, R>: UseCase<P,R> {
    typealias ParamType = P
    typealias ResultType = R
    
    var callRunCount = 0
    override func run(_ params: P...) {
        callRunCount+=1
    }
}
