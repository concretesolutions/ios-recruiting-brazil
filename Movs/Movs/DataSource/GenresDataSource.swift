//
//  GenresDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 07/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol GenresDataSource {
    func fetchGenres() -> Single<[Genre]>
}

class GenresDataSourceImpl: GenresDataSource {

    func fetchGenres() -> Single<[Genre]> {
        return requestData(url: "\(NetworkClientConstants.baseURL)/genre/movie/list")
            .map(parseGenres)
    }

    private func parseGenres(_ data: Data) -> [Genre] {
        do {
            let response = try JSONDecoder().decode(Genres.self, from: data)
            return response.genres
        } catch {
            return []
        }
    }
}
