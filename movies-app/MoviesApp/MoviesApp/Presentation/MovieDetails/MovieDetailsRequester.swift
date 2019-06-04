//
//  MovieDetailsRequester.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 04/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation
import Alamofire

typealias responseGenre = (_ response: GenreResponse) -> ()

class MoviesDetailsRequester {
    func getGenresList(path: String, responseRequest: @escaping(responseGenre)) {
        Alamofire.request(path).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                do {
                    let moviesListGender = try JSONDecoder().decode(GenreResponse.self, from: response.data!)
                    
                    responseRequest(moviesListGender)
                } catch (let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
