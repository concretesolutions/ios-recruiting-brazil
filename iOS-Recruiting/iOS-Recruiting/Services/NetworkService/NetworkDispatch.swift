//
//  NetworkDispatch.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation
import ObjectMapper

class NetworkDispatch: NetworkBaseService {
    
    static let shared = NetworkDispatch()

    typealias MappableHandler <T: Mappable> = (NetworkResult<T, NetworkError, Int>) -> Void
        
    func post<T: Mappable>(_ service: NetworkService, key: String? = nil, handler: @escaping MappableHandler<T>) {
        Network.post(service).resume { (result) in
            switch result {
            case .success(let data, let code):
                if let key = key {
                    handler(self.handleModelObject(data: data, key: key, code: code))
                } else {
                    handler(self.handleModelObject(data: data, code: code))
                }
            case .failure(let data, let code):
                handler(self.handleError(data: data, code: code))
            }
        }
    }


    func get<T: Mappable>(_ service: NetworkService, key: String? = nil, handler: @escaping MappableHandler<T>) {
        Network.get(service).resume { (result) in
            switch result {
            case .success(let data, let code):
                if let key = key {
                    handler(self.handleModelObject(data: data, key: key, code: code))
                } else {
                    handler(self.handleModelObject(data: data, code: code))
                }
            case .failure(let data, let code):
                handler(self.handleError(data: data, code: code))
            }
        }
    }
    
    func put<T: Mappable>(_ service: NetworkService, key: String? = nil, handler: @escaping MappableHandler<T>) {
        Network.put(service).resume { (result) in
            switch result {
            case .success(let data, let code):
                if let key = key {
                    handler(self.handleModelObject(data: data, key: key, code: code))
                } else {
                    handler(self.handleModelObject(data: data, code: code))
                }
            case .failure(let data, let code):
                handler(self.handleError(data: data, code: code))
            }
        }
    }
    
    func delete<T: Mappable>(_ service: NetworkService, key: String? = nil, handler: @escaping MappableHandler<T>) {
        Network.delete(service).resume { (result) in
            switch result {
            case .success(let data, let code):
                if let key = key {
                    handler(self.handleModelObject(data: data, key: key, code: code))
                } else {
                    handler(self.handleModelObject(data: data, code: code))
                }
            case .failure(let data, let code):
                handler(self.handleError(data: data, code: code))
            }
        }
    }
    

}
