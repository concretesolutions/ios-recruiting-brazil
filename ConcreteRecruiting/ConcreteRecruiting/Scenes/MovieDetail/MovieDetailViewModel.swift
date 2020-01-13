//
//  MovieDetailViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 08/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    private let movieViewModel: MovieCellViewModel
    
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
    var didChangeFavoriteState: ((Bool) -> Void)? {
        didSet {
            self.movieViewModel.didChangeFavoriteState = self.didChangeFavoriteState
        }
    }
    
    init(movieViewModel: MovieCellViewModel) {
        self.movieViewModel = movieViewModel
        
        self.acquireMovieGenres()
    }
    
    var numberOfSections: Int {
        return 5
    }
    
    var isFavorite: Bool {
        return self.movieViewModel.isFavorite
    }
    
    func getSection(for indexPath: IndexPath) -> Section {
        switch indexPath.row {
        case 0:
            return .image(data: self.movieViewModel.bannerData)
        case 1:
            return .textWithButton(text: self.movieViewModel.movieTitle)
        case 2:
            return .text(text: self.movieViewModel.releaseYear)
        case 3:
            return .text(text: self.getFormattedGenres())
        case 4:
            return .text(text: self.movieViewModel.description)
        default:
            return .text(text: "Something wrong")
        }
    }
    
    func didTapFavorite() {
        self.movieViewModel.didTapFavorite()
    }
    
    private func acquireMovieGenres() {
        
        NetworkManager.getMovieGenres { [weak self] (result) in
            switch result {
            case .success(let response):
                let movieGenres = self?.movieViewModel.getMovieGenres(from: response.genres)
                self?.genres = movieGenres ?? [Genre]()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func getFormattedGenres() -> String {
        
        let numberOfGenres = self.genres.count
        
        // TODO: Change to Localizable
        if numberOfGenres == 0 {
            return "No genre information"
        }
        
        var genresText = ""
        
        for (index, genre) in self.genres.enumerated() {
            genresText += genre.name
            
            let isLast = (index == numberOfGenres-1)
            genresText += (isLast ? "" : ",")
        }

        return genresText
    }
    
}

enum Section {
    case text(text: String)
    case textWithButton(text: String)
    case image(data: Data)
}
