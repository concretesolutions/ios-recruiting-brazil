//
//  MoviesListPresenter.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation
import Alamofire

typealias responseHandler = (_ response: MoviesList) -> ()

class MoviesListProvider {
    func getPopularMoviesList(url: String, response: @escaping(responseHandler)) {
        Alamofire.request(url).responseJSON(completionHandler: { response in
            switch response.result {
                case .success(_): {
                    let response = try JSONDecoder().decode(MoviesList.self, from response.data!)
                    responseHandler(response)
                }
                
                case .failure(let error) {
                    print(error)
                }
            }
        })
    }
}
