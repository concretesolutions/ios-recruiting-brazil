//
//  ListMoviesInteractor.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 24/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import RxSwift

class ListMoviesInteractor: ListMoviesUseCase {
    
    //MARK: - Contract Properties
    weak var output: ListMoviesInteractorOutput!
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private var moviesRequestPage: Int = 1
    
    //MARK: - Contract Functions
    func fetchGenres() {
        APIClient
            .fetchData(host: .TMDB_API, url: APICallMethods.getGenres, type: GenresEntity.self)
            .subscribe(
                onNext: { response in
                    self.output.fetchedGenres(response)
            },
                onError: { error in
                    self.output.fetchedGenresFailed()
            })
            .disposed(by: disposeBag)
    }
    
    func fetchMovies() {
        APIClient
            .fetchData(host: .TMDB_API, url: APICallMethods.getPopularMovies(page: moviesRequestPage), type: MoviesAPIResponse.self)
            .subscribe(
                onNext: { response in
                    self.output.fetchedMovies(response.results)
            },
                onError: { error in
                    self.output.fetchedMoviesFailed()
            })
            .disposed(by: disposeBag)
        moviesRequestPage += 1
    }
    
    func fetchPosters(movies: [MovieEntity]) {
        for item in movies {
            if let poster = item.poster {
                APIClient
                    .fetchImage(host: .TMDB_IMAGE, url: APICallMethods.getPoster(posterPath: poster))
                    .subscribe(
                        onNext: { response in
                            response.movieId = item.id
                            self.output.fetchedPoster(response)
                            
                    },
                        onError: { error in
                            self.output.fetchedPosterFailed()
                    })
                    .disposed(by: disposeBag)
                }
            }
    }
    
}
