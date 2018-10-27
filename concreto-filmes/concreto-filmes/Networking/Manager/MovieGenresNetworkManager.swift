//
//  GenresNetworkManager.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 26/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

class MovieGenresNetworkManager: NetworkManager<GenresApi> {
    func getGenres(completion: @escaping ([Genre]?, _ error: String?) -> Void) {
        router.request(.movieList) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(GenreApiResponse.self, from: responseData)
                        completion(apiResponse.genres, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
