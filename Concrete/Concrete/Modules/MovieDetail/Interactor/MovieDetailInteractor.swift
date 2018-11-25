//
//  MovieDetailInteractor.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MovieDetailInteractor {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    private(set) var movie:Movie
    
    // MARK: - Init
    init(movie:Movie) {
        self.movie = movie
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func set(favorite:Bool) {
        self.movie.isFavorite = favorite
    }
    
    func genreTitles() -> [String] {
        let coreDataManager = CoreDataManager<Genre>()
        let title = [String]()
        
        do {
            let genres = try coreDataManager.get()
            let movieGenres = genres.filter { (genre) -> Bool in
                return self.movie.genresIds.contains(Int(genre.id))
            }
            let genreTitles = movieGenres.map { (genre) -> String in
                return genre.name!
            }
            
            return genreTitles
        } catch {
            Logger.logError(in: self, message: "CoreData could not fetch Genre")
            return title
        }
    }
}
