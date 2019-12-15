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
    
    func fetchTrendingMovies(mediaType: MediaType = .all, timeWindow: TimeWindow = .day) {
        fetch(endPoint: EndPoint.getTrending(mediaType: mediaType, timeWindow: timeWindow)) { error in
            self.dataSource?.dataFetchDelegate?.didFailFetchData(with: error)
        }
    }
    
    func searchMovies(query: String) {
        fetch(endPoint: EndPoint.searchMovie(query: query)) { error in
            self.dataSource?.dataFetchDelegate?.didFailFetchData(with: error)
        }
    }
    
    private func fetch(endPoint: EndPoint, errorHandling: @escaping (NetworkError) -> Void) {
        let apiProvider = APIProvider<Movie>()
        apiProvider.request(endPoint) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success(let response):
                self.dataSource?.data = response.results
            case.failure(let error):
                errorHandling(error)
            }
        }
    }
    
    @discardableResult
    func favorite(_ movie: Movie) -> FavoriteMovie? {
        let favMovie: FavoriteMovie? = CoreDataManager.fetchBy(id: movie.id)
  
        if favMovie == nil, let title = movie.title ?? movie.name {
            let favoriteMovie = FavoriteMovie(id: Int64(movie.id),
                                              title: title,
                                              image: movie.movieImageData!)
            CoreDataManager.saveContext()
            return favoriteMovie
        } else if favMovie != nil {
            CoreDataManager.deleteBy(id: movie.id, entityType: FavoriteMovie.self)
        }
        
        return nil
    }
    
    @discardableResult
    func removeFavorite(_ movie: Movie) -> FavoriteMovie? {
        CoreDataManager.deleteBy(id: movie.id, entityType: FavoriteMovie.self)
        
        return nil
    }
}
