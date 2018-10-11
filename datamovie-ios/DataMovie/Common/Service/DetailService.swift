//
//  DetailService.swift
//  DataMovie
//
//  Created by Andre Souza on 06/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class DetailService: NSObject {
    
    func get(movieID: Int, page: Int, _ completion: @escaping (RequestResultType<DiscoverMovieListModel>) -> Void) {
        let url = DMUrl.url(for: .recommendations(movieID, page))
        let service = APIService(with: url)
        service.getData(completion)
    }
    
}
