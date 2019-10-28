//
//  DetailsViewControllerViewModel.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

class DetailsViewControllerViewModel {
    var delegate: DetailsViewControllerProtocol!
    var dao: SQLiteManager!
    
    init(delegate: DetailsViewControllerProtocol) {
        self.delegate = delegate
        dao = SQLiteManager()
    }
    
    func requestGenre(from movie: MovieResponse) {
        func onError(message: String) {
            delegate.setMovie(genre: message)
        }
        func onSuccess(genres: GenreListResponse) {
            filterGenreList(genres, movie)
        }
        API.MovieService().getGenreList(onError: onError(message:), onSuccess: onSuccess(genres:))
    }
    
    private func filterGenreList(_ genres: GenreListResponse, _ movie: MovieResponse) {
        if let genreListReponse = genres.genres,
            let movieIdGenreList = movie.genreIds {
            var movieGenre = ""
            
            for movieIdGenre in movieIdGenreList {
                for genreResponse in genreListReponse {
                    if movieIdGenre == genreResponse.id {
                        movieGenre.append(contentsOf: genreResponse.name ?? "")
                        movieGenre.append(contentsOf: " ")
                        break
                    }
                }
            }
            delegate.setMovie(genre: movieGenre)
        }
    }
    
    func didTapFavoriteButton(movie: MovieResponse) {
        if movie.isFavorited {
            dao.deleteFavoritedMovie(movie)
        } else {
            dao.insertFavoritedMovie(movie)
        }
        delegate.setFavoritedMovie(status: !movie.isFavorited)
    }
}
