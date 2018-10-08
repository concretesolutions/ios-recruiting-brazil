//
//  MovieDetailClient.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieDetailClient {
    private lazy var service = Service()
}

//MARK: - GetGenreList methods -
extension MovieDetailClient {
    func getGenreList(with genreIds: [Int], completion: @escaping (ResponseResultType<GenreListModel>) -> Void) {
        let userDefault = UserDefaultWrapper()
        if  let genreListData: Data = userDefault.get(with: userDefault.genresIdsKey),
            let genreList = try? JSONDecoder().decode(GenreListModel.self, from: genreListData) {
            completion(.success(genreList))
        } else {
            let url = TMDBUrl().getUrl(to: .genreIds)
            service.get(in: url) { [weak self] (result: ResponseResultType<GenreListModel>) in
                switch result {
                case let .success(genreList):
                    self?.saveGenreList(with: genreList)
                    completion(.success(genreList))
                case let .fail(error):
                    completion(.fail(error))
                }
            }
        }
    }
    
    private func saveGenreList(with genreListModel: GenreListModel) {
        guard let data = try? JSONEncoder().encode(genreListModel) else { return }
        let userDefault = UserDefaultWrapper()
        userDefault.save(object: data, with: userDefault.genresIdsKey)
    }
}
