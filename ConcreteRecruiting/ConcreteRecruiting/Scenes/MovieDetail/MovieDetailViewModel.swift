//
//  MovieDetailViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 08/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    private let movie: Movie
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    private var genres: [Genre] = [Genre]() {
    
        didSet {
            self.didAcquireGenres?()
        }
        
    }
    
    var didAcquireGenres: (() -> Void)?
    
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var numberOfSections: Int {
        return 6
    }
    
    private func getFormattedYear() -> String {
        
        guard let date = self.movie.releaseDate else { return "" }
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    } 
    
    func getTopic(for indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 1:
            return self.movie.title
        case 2:
            return self.getFormattedYear()
        case 3:
            return ""
        case 4:
            return self.movie.description
        default:
            return "Something wrong"
        }
    }
    
    private func acquireMovieGenres() {
        
        NetworkManager.getMovieGenres { (result) in
            switch result {
            case .success(let response):
                self.genres = response.genres
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func getFormattedGenres() -> String {

        var genresText = ""
        let numberOfGenres = self.genres.count
        
        // TODO: Change to Localizable
        if numberOfGenres == 0 {
            return "No genre information"
        }

        for (index,genre) in self.genres.enumerated() {
            genresText += genre.name
            
            let isLast = (index == self.genres.count-1)
            genresText += (isLast ? "" : ",")
        }

        return genresText
    }
    
    
}
