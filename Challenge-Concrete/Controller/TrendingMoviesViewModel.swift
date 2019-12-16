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
    
    func fetchTrendingMovies(mediaType: MediaType = .movie, timeWindow: TimeWindow = .day) {
        fetch(endPoint: EndPoint.getTrending(mediaType: mediaType, timeWindow: timeWindow))
    }
    
    func searchMovies(query: String) {
        fetch(endPoint: EndPoint.searchMovie(query: query))
    }
    
    func fetchGenres(completion: (([Genre]) -> Void)? = nil) {
        let apiProvider = APIProvider<Genre>()
        apiProvider.request(EndPoint.getGenres) { (result: Result<GenreResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    let genres = response.genres
                    if self.genreIsDifferentFromLocal(genres) {
                        self.saveAllGenresLocal(genres)
                    }
                    completion?(genres)
                case .failure: break
                }
        }
    }
    
    func genreIsDifferentFromLocal(_ genres: [Genre]) -> Bool {
        var isDifferent = true
        for genre in genres {
            if let _: GenreLocal = CoreDataManager.fetchBy(id: genre.id) {
                isDifferent = false
                break
            }
        }
        
        return isDifferent
    }
    
    func saveAllGenresLocal(_ genres: [Genre]) {
        CoreDataManager.delete(entityType: GenreLocal.self)
        genres.forEach { genre in
            saveGenreLocal(genre)
        }
    }
    
    private func saveGenreLocal(_ genre: Genre) {
        _ = GenreLocal(id: Int64(genre.id), name: genre.name)
        CoreDataManager.saveContext()
    }
    
    private func fetch(endPoint: EndPoint) {
        let apiProvider = APIProvider<Movie>()
        apiProvider.request(endPoint) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success(let response):
                if response.results.count > 0 {
                    self.dataSource?.data = response.results
                } else {
                    self.dataSource?.dataFetchDelegate?.didFailFetchData(with: NetworkError.emptyResult)
                }
            case.failure(let error):
                self.dataSource?.dataFetchDelegate?.didFailFetchData(with: error)
            }
        }
    }
}
