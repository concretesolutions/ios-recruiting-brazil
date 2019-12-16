//
//  TrendingMoviesViewModel.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import CoreData

class TrendingMoviesViewModel: MovieViewModel {
    
    weak var dataSource: MovieCollectionDataSource?
    
    func fetchTrendingMovies(mediaType: MediaType = .movie, timeWindow: TimeWindow = .day, page: Int = 1) {
        fetch(endPoint: EndPoint.getTrending(mediaType: mediaType, timeWindow: timeWindow, page: page))
    }
    
    func searchMovies(query: String) {
        fetch(endPoint: EndPoint.searchMovie(query: query))
    }
    
    func fetchGenres() {
        let apiProvider = APIProvider<Genre>()
        apiProvider.request(EndPoint.getGenres) { (result: Result<GenreResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    
                    let genres = response.genres
                    DispatchQueue.main.async {
                        if self.genreIsDifferentFromLocal(genres) {
                            self.saveAllGenresLocal(genres)
                        }
                    }
                case .failure: break
                }
        }
    }
    
    func genreIsDifferentFromLocal(_ genres: [Genre]) -> Bool {
        var isDifferent = true
        for genre in genres {
            if let _: GenreLocal = CoreDataManager.shared.fetchBy(id: genre.id) {
                isDifferent = false
                break
            }
        }
        return isDifferent
    }
    
    func saveAllGenresLocal(_ genres: [Genre]) {
        CoreDataManager.shared.delete(entityType: GenreLocal.self)
        genres.forEach { genre in
            self.saveGenreLocal(genre)
        }
    }
    
    private func saveGenreLocal(_ genre: Genre) {
        _ = GenreLocal(id: Int64(genre.id), name: genre.name)
        CoreDataManager.shared.saveContext()
    }
    
    private func fetch(endPoint: EndPoint) {
        let apiProvider = APIProvider<Movie>()
        apiProvider.request(endPoint) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success(let response):
                if response.results.isEmpty {
                    self.dataSource?.dataFetchDelegate?.didFailFetchData(with: NetworkError.emptyResult)
                } else {
                    if case .getTrending(_,_,let page) = endPoint {
                        if page > 1 {
                            self.dataSource!.data.append(contentsOf: response.results)
                            return
                        }
                    }
                }
                self.dataSource?.data = response.results
            case.failure(let error):
                self.dataSource?.dataFetchDelegate?.didFailFetchData(with: error)
            }
        }
    }
}
