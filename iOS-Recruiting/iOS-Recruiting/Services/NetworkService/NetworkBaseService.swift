//
//  NetworkBaseService.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation
import ObjectMapper

protocol NetworkBaseService {
    func handleError<T>(data: Data, code: Int) -> NetworkResult<T, NetworkError, Int>
    func handleModelObject<T: Mappable>(data: Data, key: String?, code: Int) -> NetworkResult<T, NetworkError, Int>
}

extension NetworkBaseService {
    
    func handleError<T>(data: Data, code: Int) -> NetworkResult<T, NetworkError, Int> {
        if let JSON = data.modelObject(), let container = CustomError(JSON: JSON) {
            return NetworkResult.failure(NetworkError.withContainer(container: container), code)
        }
        let error = NSError.from(code: code, data: data)
        return NetworkResult.failure(NetworkError.withError(error: error), code)
    }
    
    func handleModelObject<T>(data: Data, key: String? = nil, code: Int) -> NetworkResult<T, NetworkError, Int> where T : Mappable {
        if let key = key {
            if let JSON = data.modelObject(), let container = CustomError(JSON: JSON), container.toJSON().count > 0 {
                return NetworkResult.failure(NetworkError.withContainer(container: container), code)
            } else if let JSON = data.modelObject(key: key), let model = Mapper<T>().map(JSON: JSON) {
                return NetworkResult.success(model, code)
            } else {
                return NetworkResult.failure(NetworkError.undefined, code)
            }
        } else {
            if let JSON = data.modelObject(), let container = CustomError(JSON: JSON), container.toJSON().count > 0 {
                return NetworkResult.failure(NetworkError.withContainer(container: container), code)
            } else if let JSON = data.modelObject(), let model = Mapper<T>().map(JSON: JSON) {
                return NetworkResult.success(model, code)
            } else {
                return NetworkResult.failure(NetworkError.undefined, code)
            }
        }
    }
    
    
}
