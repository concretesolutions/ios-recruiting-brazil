//
//  UseCaseProtocol.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import RxSwift

protocol UseCaseProtocol {
    associatedtype ResultType
    associatedtype ParamType
    
    var resultStream: Observable<ResultType> { get }
    
    func run(_ params: ParamType...)
}

class UseCase<P, R>: UseCaseProtocol {
    typealias ResultType = R
    typealias ParamType = P
    
    var resultPublisher = PublishSubject<R>()
    var resultStream: Observable<R> {
        get {
            return resultPublisher.asObservable()
        }
    }
    
    func run(_ params: P...) {}
}
