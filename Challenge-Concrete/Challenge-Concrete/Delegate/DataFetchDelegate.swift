//
//  DataFetchDelegate.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

protocol DataFetchDelegate: AnyObject {
    func didUpdateData()
    func didFailFetchData(with error: Error)
}
