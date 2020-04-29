//
//  Genre.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 18/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

class GenreResponse: Codable {
    let genres: [Genre]
}

class Genre: Codable {
    let name: String
    var id: Int
    
    static func getAll() -> Single<[Genre]> {
        let endopoint: Endpoint<GenreResponse> = Endpoint(path: "genre/movie/list")
        return Single<[Genre]>.create { observer in
            Client.shared.request(endopoint)
                .subscribe(onSuccess: { data in
                    observer(.success(data.genres))
                }, onError: { error in
                    switch error {
                    case ApiError.conflict:
                        print("Conflict error")
                    case ApiError.forbidden:
                        print("Forbidden error")
                    case ApiError.notFound:
                        print("Not found error")
                    default:
                        print("Unknown error:", error)
                    }
                    observer(.error(error))
                })
        }
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
