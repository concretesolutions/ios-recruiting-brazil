//
//  DiscoverMovieService.swift
//  DataMovie
//
//  Created by Andre on 26/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class DiscoverMovieService: NSObject {
    
    typealias Entity = DiscoverMovieListModel
    
    func get(endPoint enpoint: DiscoverEndpoint, _ completion: @escaping (RequestResultType<Entity>) -> Void) {
        let url = DMUrl.url(for: .discover(enpoint))
        let service = APIService(with: url)
        service.getData(completion)
    }
    
}
