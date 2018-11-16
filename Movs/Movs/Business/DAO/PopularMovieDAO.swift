//
//  PopularMovieDAO.swift
//  Movs
//
//  Created by Adann Simões on 16/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation
import Alamofire

struct PopularMovieDAO {
    static func getPopularMovie(page: Int, completionHandler: @escaping (PopularMovie?, Error?) -> Void) {
        let endpoint = "\(APIRoute.Base.rawValue + APIRoute.PopularMovie.rawValue)"
        let params: Parameters = [
            "api_key": APIKey.Key.rawValue,
            "language": Language.Portuguese.rawValue,
            "page": page
        ]

        let teste = "https://api.themoviedb.org/3/movie/popular?api_key=a6d13c5f45d8dfa6cf3ff4334863c9a1&language=pt-BR&page=1"
        
        Alamofire.request(teste,
                          method: .get,
                          parameters: params).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if let data = response.result.value {
                        let jsonProfile = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        let parsedResponse = try JSONDecoder().decode(PopularMovie.self, from: jsonProfile)
                        completionHandler(parsedResponse, nil)
                    }
                } catch {
                    completionHandler(nil, ErrorInformation.InvalidFormat)
                }
            case .failure:
                guard let error = response.result.error else {
                    return
                }
                completionHandler(nil, error)
            }
        }
        
    }
}
