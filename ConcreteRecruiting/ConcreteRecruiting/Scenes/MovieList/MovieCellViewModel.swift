//
//  MovieCellViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    
    private var movie: Movie
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    var didAcquireBannerData: ((Data) -> Void)?
    
    init(with movie: Movie) {
        self.movie = movie
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    private var posterData = Data() {
        didSet {
            self.didAcquireBannerData?(self.posterData)
        }
    }
    var bannerData: Data {
        return posterData
    }
    
    var isFavorite: Bool {
        return movie.isFavorite
    }
    
    var numberOfTopics: Int {
        return 5
    }
    
    //    var genres: String {
    //        return getFormattedGenres()
    //    }
    
    private func getFormattedYear() -> String {
        
        guard let date = self.movie.releaseDate else { return "" }
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
//    private func getFormattedGenres() -> String {
//
//        var genresText = ""
//        let moreThanOne = self.movie.genres.count >= 2
//
//        for genre in self.movie.genres {
//            genresText += genre.
//        }
//
//        return genresText
//    }
    
    func acquireBannerData() {
        NetworkManager.getPosterImage(path: self.movie.bannerPath) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.posterData = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTopic(for indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 1:
            return movieTitle
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
    
    func didTapFavorite() {
        
        movie.isFavorite = !movie.isFavorite
        
        // TODO: Persist the favorite somewhere
        
    }
    
}
