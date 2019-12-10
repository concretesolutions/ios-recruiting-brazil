//
//  GenericDataSource.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import Foundation
class GenericDataSource<T> : NSObject {
    weak var dataFetchDelegate: DataFetchDelegate?
    var data: [T] = [] {
        didSet {
            dataFetchDelegate?.didUpdateData()
        }
    }
}
