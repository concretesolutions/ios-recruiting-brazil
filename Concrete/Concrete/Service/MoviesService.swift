//
//  MoviesService.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Alamofire

class MoviesService {
    func loadMovies(page: String, callback: @escaping (Movies?, Error?) -> Void) {

        let URL = ConstUrl.url(page: page)
        AF.request(URL).responseDecodable { (response: DataResponse<Movies>) in

            guard response.error == nil else {
                print("🥶: \(String(describing: response.error))")
                callback(nil, response.error)
                return
            }

            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(Movies.self, from: data)
                    callback(response, nil)
                } catch let error {
                    print("Error creating current news from JSON because: \(error.localizedDescription)")
                    callback(nil, error)
                }
            }
        }
    }
}
