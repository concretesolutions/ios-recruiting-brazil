//
//  AddMovieService.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import Alamofire

class AddMovieService: NSObject {
    
    func getMovieDetail(tmdbID: Int, _ completion: @escaping (RequestResultType<MovieModel>) -> Void) {
        let url = DMUrl.url(for: .detail(tmdbID, [.credits,.videos]))
        let service = APIService(with: url)
        service.getData(completion)
    }
    
    func downloadPosterImage(posterPath: String, _ completion: @escaping (DataResponse<Data>) -> Void) {
        if !posterPath.isEmpty {
            let url = TMDBUrl.image(.w200, posterPath).url
            let service = APIService(with: url)
            service.downloadData(completionHandler: completion)
        }
    }
    
}
