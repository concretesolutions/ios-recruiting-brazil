//
//  MoviesListRequester.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation
import Alamofire

typealias responseHandler = (_ response: MoviesList) -> ()

class MoviesListRequester {
    func getPopularMoviesList(path: String, responseRequest: @escaping(responseHandler)) {
        Alamofire.request(path).responseJSON(completionHandler: { response in
            switch response.result {
                case .success(_):
                    do {
                        let moviesListResponse = try JSONDecoder().decode(MoviesList.self, from: response.data!)
                        
                        responseRequest(moviesListResponse)
                    } catch (let error) {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
            }
        })
    }
}
