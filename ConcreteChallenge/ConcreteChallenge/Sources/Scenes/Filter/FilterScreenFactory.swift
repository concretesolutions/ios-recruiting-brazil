//
//  FilterTypeFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit
import Moya

enum FilterScreenFactory {
    static func makeFilterType() -> UIViewController {
        let providerStubClosure = MoyaProvider<MovieDbAPI>.neverStub
        let provider = MoyaProvider<MovieDbAPI>(stubClosure: providerStubClosure, plugins: [NetworkLoggerPlugin()])
        let worker = MoyaWorker(provider: provider)

        let presenter = FilterPresenter()

        let interactor = FilterInteractor(worker: worker, presenter: presenter)

        let filterViewController = FilterViewController(interactor: interactor)

        return filterViewController
    }
}
