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

//MARK: - FavList Methods -
extension MovieDetailClient {
    func getfavList() -> [MovieDetailModel]? {
        let userDefault = UserDefaultWrapper()
        guard let favListData: [Data]? = userDefault.get(with: userDefault.favsListKey) else { return nil }
        let favList = favListData?.compactMap { try? JSONDecoder().decode(MovieDetailModel.self, from: $0) }
        return favList
    }
    
    func removeModelInFavsList(with model: MovieDetailModel) -> Bool {
        let userDefault = UserDefaultWrapper()
        model.isFav = false
        guard
            let favList = getfavList(),
            let index = favList.firstIndex(where: { $0 == model }),
            let _: [Data] = userDefault.deleteItem(in: index, with: userDefault.favsListKey)
            else {
                model.isFav = true
                return false
        }
        return true
    }
    
    func saveModelInFavsList(with model: MovieDetailModel) -> Bool {
        model.isFav = true
        let userDefault = UserDefaultWrapper()
        guard let data = try? JSONEncoder().encode(model) else {
            model.isFav = false
            return false
        }
        userDefault.appendItem(data, with: userDefault.favsListKey)
        return true
    }
}
