//
//  MovieViewModel.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation
import UIKit

protocol MovieViewModelDelegate:class {
    func didFinishSuccessRequest()
    func didFinishFailureRequest(error: APIError)
}

class MovieViewModel {
    
    weak var delegate:MovieViewModelDelegate?
    
    var movie: Movie!
    
    var title: String {
        return movie.title
    }
    
    var genresList: [Genre] = []
    
    var overview: String {
        return movie.overview
    }
    
    var releaseDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        
        if let release = movie.releaseDate {
            return formatter.date(from: release)
        } else {
            return nil
        }
    }
    
    var year: String {
        
        if let releaseDate = releaseDate {
            let year = Calendar.current.component(Calendar.Component.year, from: releaseDate)
            return String(year)
        }
        return "----"
    }
    
    var posterPath: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath)")
    }
    
    var id: Int64 {
        return movie.id
    }
    
    var favorite: Bool {
        return favoriteManager.fetchById(index: id)?.count != 0
    }
    
    var favoriteButtonImage: UIImage {
        return favorite ? UIImage(named: "favorite_full_icon")! : UIImage(named: "favorite_gray_icon")!
    }
    
    var genresService: GenresService = GenresServiceImpl()
    
    var favoriteManager: FavoriteMoviesManagerProtocol = FavoriteMoviesManager()
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    func addOrRemoveFavoriteMovie(favoriteMovie: MovieViewModel) {
        
        if favoriteManager.fetchById(index: favoriteMovie.id)?.count == 0 {
            favoriteManager.addFavoriteMovie(movieVM: favoriteMovie)
        } else {
            favoriteManager.delete(id: favoriteMovie.id)
        }
    }
    
    func movieGenresList() {
        
        genresService.requestGenreList { (result) in
            switch result {
            case .failure(let error):
                self.delegate?.didFinishFailureRequest(error: error)
            case .success(let genres):
                self.genresList = genres.genres.filter({genre in self.movie.genreIds.contains(where: {$0 == genre.id})})
                self.delegate?.didFinishSuccessRequest()
            }
        }
    }
}
