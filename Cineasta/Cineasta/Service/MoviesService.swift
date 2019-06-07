//
//  MoviesService.swift
//  Cineasta
//
//  Created by Tomaz Correa on 03/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation
import Alamofire

class MoviesService {
    func getMovies(page: Int,
                   errorCompletion: @escaping(_ error: Error?) -> Void,
                   successCompletion: @escaping(_ moviesResult: MoviesResult) -> Void) {
        let serviceUrl = self.getServiceURL(page: page)
        Alamofire.request(serviceUrl).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                guard let data = response.data,
                 let moviesResult = try? JSONDecoder().decode(MoviesResult.self, from: data) else {
                    return errorCompletion(ServiceError.error)
                }
                 successCompletion(moviesResult)
            case .failure:
                errorCompletion(ServiceError.error)
            }
        })
    }
    
    private func getServiceURL(page: Int) -> String {
        var serviceUrl = "\(Constants.Hosts.movieAPI)"
        serviceUrl.append(Constants.Paths.popularMovies)
        serviceUrl.append("?api_key=\(Constants.Service.apiKey)")
        serviceUrl.append("&language=pt-BR&page=\(page)")
        return serviceUrl
    }
}
