//
//  MoviesThunk.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import RxSwift
import ReSwift
import ReSwiftThunk

class MovieThunk {
    static let disposeBag = DisposeBag()
    
    
    static func dependencyUpdated() -> Thunk<RootState> {
        
        return Thunk<RootState> { dispatch, getState in
            guard let state: RootState = getState() else { return }

            var movies: [Movie] = []
            
            do {
                for (key, movie) in state.movie.movies.enumerated() {
                    
                    let genres = state.genre
                        .genres.filter({ movie.genreIds.contains($0.id) })
                        .map({ $0.name })
                    let favorited = state.favorites
                        .favorites.contains(where: { $0.id == movie.id })
                    
                    if (genres != movie.genres || favorited != movie.favorited) {
                        movies.append(try movie.clone())
                    } else {
                        movies.append(movie)
                    }
                    
                    movies[key].genres = genres
                    movies[key].favorited = favorited
                    
                }
                
                DispatchQueue.main.async {
                    dispatch(MovieActions.set(movies))
                }
            } catch {
                
            }

            
            
        }
    }
    
    static func fetchDetails(of movieId: Int) -> Thunk<RootState> {
        
        return Thunk<RootState> { dispatch, getState in
            guard let state = getState() else { return }
            
            if state.movie.loading || !state.infra.isConnected {
                return
            }
            
            
            var details: MovieDetails?
            
            if let movieMinimalDetails = state.movie.movies.first(where: { $0.id == movieId }) {
                details = MovieDetails(with: movieMinimalDetails)
            } else {
                if let favoriteMinimalDetails = state.favorites.favorites.first(where: { $0.id == movieId }) {
                    details = MovieDetails(with: favoriteMinimalDetails)
                }
            }
            
            if let details = details {
                DispatchQueue.main.async {
                    dispatch(MovieActions.movieDetails(details))
                }
            }
            
            
            
            MovieDetails.get(id: movieId)
                .subscribe(
                    onSuccess: { fullDetails in
                        DispatchQueue.main.async {
                            dispatch(MovieActions.movieDetails(fullDetails))
                        }
                    },
                    onError: { error in
                        DispatchQueue.main.async {
                            dispatch(MovieActions.requestError(
                                message: "Erro ao carregar filme"
                            ))
                        }
                    }
                )
                .disposed(by: MovieThunk.disposeBag)
            
        }
    }
    
    static func fetchPopular(at page: Int) -> Thunk<RootState> {
        
        return Thunk<RootState> { dispatch, getState in
            guard let state = getState() else { return }
            
            if state.movie.loading || !state.infra.isConnected {
                return
            }
            
            DispatchQueue.main.async {
                dispatch(MovieActions.requestStated)
            }
            
            
            Movie.popular(page: 1)
                .subscribe(
                    onSuccess: { movies in
                        DispatchQueue.main.async {
                            dispatch(MovieActions.addMovies(page: page, movies: movies))
                        }
                    },
                    onError: { error in
                        DispatchQueue.main.async {
                            dispatch(
                                MovieActions.requestError(message: "Erro ao carregar filmes")
                            )
                        }
                    }
                )
                .disposed(by: MovieThunk.disposeBag)
        }
    }
}
