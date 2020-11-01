//
//  FilterInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FilterBusinessLogic: AnyObject {

}

final class FilterInteractor: FilterBusinessLogic {
    private let worker: MoyaWorkerProtocol
    private let presenter: FilterPresentationLogic

    // MARK: - Initializers

    init(worker: MoyaWorkerProtocol, presenter: FilterPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}
