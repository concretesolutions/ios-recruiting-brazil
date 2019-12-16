//
//  Provider.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

protocol Provider {
    func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void)
    func request(service: Service, completion: @escaping (Result<Data, Error>) -> Void)
}
