//
//  MovieClient.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Alamofire


class MovieClient {
    @discardableResult
    private static func performRequest(route: MoviesEndpoint, completion: @escaping (DataResponse<Any, AFError>?) -> Void) -> DataRequest {
        return AF.request(route).validate().responseJSON() { (response: DataResponse<Any, AFError>?) in
            completion(response)
        }
    }
    
    // TO DO: - Função de get popular movies / get genres / search
    
    
    
}
