//
//  MovieService.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

extension API {
    struct MovieService {
        func getMoviePopular(page: Int, onError: @escaping (String) -> Void, onSuccess: @escaping (MovieListResponse) -> Void) {
            let endPoint = getMoviePopularEndPoint.replacingOccurrences(of: "{page}", with: String(page))
            API.request(url: endPoint, httpMethod: .get, onError: onError, onSuccess: onSuccess)
        }
    }
}
