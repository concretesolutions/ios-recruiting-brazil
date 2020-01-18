//
//  MovieDBApi.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//


import Foundation
import Alamofire

class MovieDBApi{
    class func getPopularMovies(withPage page: Int,
                                onComplete: @escaping ([Movie]) -> Void, onError: @escaping (Error) -> Void) {
        
        let params = [
            "api_key": API_MOVIEDB_KEY,
            "language": API_MOVIEDB_LANGUAGE,
            "page": page
            ] as [String: Any]
        Alamofire.request(API_MOVIEDB_URL_MOST_POPULAR, parameters: params).responseJSON { (response) in
            if let error = response.error {
                onError(error)
            } else {
                if let data = response.result.value as? [String: Any] {
                    if let result = data["results"] as? [[String: Any]] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                            let moviesResponse = try JSONDecoder().decode([Movie].self, from: data)
                            onComplete(moviesResponse)
                        } catch {
                            onError(error)
                        }
                    }
                }
            }
        }
    }
}
