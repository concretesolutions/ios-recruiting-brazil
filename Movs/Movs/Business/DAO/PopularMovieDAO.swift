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
        //swiftlint:disable line_length
        let endpoint = "\(APIRoute.Base.rawValue + APIRoute.PopularMovie.rawValue)?api_key=\(APIKey.Key.rawValue)&language=\(Language.Portuguese.rawValue)&page=\(page)"
        //swiftlint:enable line_length
        
        Alamofire.request(endpoint,
                          method: .get).responseJSON { response in
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
