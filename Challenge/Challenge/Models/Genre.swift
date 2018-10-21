//
//  Genre.swift
//  Challenge
//
//  Created by Sávio Berdine on 20/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation
import Alamofire

class Genre {
    var id: Int?
    var name: String?
    
    init() {
        self.id = 0
        self.name = ""
    }
    
    static var currentGenres: [Genre] = []
    
    class func getCurrentGenres(onSuccess: @escaping (_ genres: [Genre]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        var resultGenres: [Genre] = []
        let headers: HTTPHeaders = ["content-type": "application/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/genre/movie/list?api_key=\(Tmdb.apiKey)&language=en-US", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error requesting account details")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            if let dbGenres = value["genres"] as? [[String: Any]] {
                for element in dbGenres {
                    let localGenre = Genre()
                    if let genreId = element["id"] as? Int {
                        localGenre.id = genreId
                    }
                    if let genreName = element["name"] as? String {
                        localGenre.name = genreName
                    }
                    resultGenres.append(localGenre)
                }
                onSuccess(resultGenres)
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
}
