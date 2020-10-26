//
//  DataSource.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

class DataSource<M>: NSObject {
    private var models: [M]

    // MARK: - Initializers

    init(models: [M]) {
        self.models = models

        super.init()
    }

    // MARK: - Computed variables

    var count: Int {
        return models.count
    }

    // MARK: - Functions

    func get(at index: Int) -> M {
        return models[index]
    }

    func set(models: [M]) {
        self.models = models
    }
}
