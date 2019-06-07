//
//  GenresService.swift
//  Cineasta
//
//  Created by Tomaz Correa on 05/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation
import Alamofire

class GenresService {
    func getGenres(errorCompletion: @escaping(_ error: Error?) -> Void,
                   successCompletion: @escaping(_ genresResult: GenresResult) -> Void) {
        let serviceUrl = self.getServiceURL()
        Alamofire.request(serviceUrl).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                guard let data = response.data,
                    let genresResult = try? JSONDecoder().decode(GenresResult.self, from: data) else {
                        return errorCompletion(ServiceError.error)
                }
                successCompletion(genresResult)
            case .failure:
                errorCompletion(ServiceError.error)
            }
        })
    }
    
    private func getServiceURL() -> String {
        var serviceUrl = "\(Constants.Hosts.movieAPI)"
        serviceUrl.append(Constants.Paths.genres)
        serviceUrl.append("?api_key=\(Constants.Service.apiKey)")
        serviceUrl.append("&language=pt-BR")
        return serviceUrl
    }
}
