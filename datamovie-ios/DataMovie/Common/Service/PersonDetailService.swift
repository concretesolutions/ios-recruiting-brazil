//
//  PersonDetailService.swift
//  DataMovie
//
//  Created by Andre on 15/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class PersonDetailService: NSObject {
    
    typealias Entity = PersonDetailModel
    
    func get(personID: Int, _ completion: @escaping (RequestResultType<Entity>) -> Void) {
        let url = DMUrl.url(for: .person(personID))
        let service = APIService(with: url)
        service.getData(completion)
    }
    
}
