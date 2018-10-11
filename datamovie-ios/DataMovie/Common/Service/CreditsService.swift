//
//  CreditsService.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class CreditsService: NSObject {
    
    typealias Entity = CreditsModel
    
    func get(tmdbID: Int, _ completion: @escaping (RequestResultType<Entity>) -> Void) {
        let url = DMUrl.url(for: .credits(tmdbID))
        let service = APIService(with: url)
        service.getData(completion)
    }
    
}
