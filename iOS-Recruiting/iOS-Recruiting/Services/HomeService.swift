//
//  HomeService.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation

class HomeService: NetworkBaseService {
    
    static let shared = HomeService()
    
//    typealias HomeHighlightsHandler = (NetworkResult<HomeHighlights, NetworkError, Int>) -> Void
//    
//    // MARK: - Endpoints
//    internal func getHomeHighlights(city: Filter, handler: @escaping HomeHighlightsHandler) {
//        let path = "sections"
//        let parameters = ["area" : city.slug ?? ""]
//        let service = NetworkService(api: .ldrv6, path: path, parameters: parameters)
//        NetworkDispatch.shared.get(service) {
//            handler($0)
//        }
//    }

}
