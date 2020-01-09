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
    
    var releaseYear: String {
        
        guard let date = self.movie.releaseDate else { return "" }
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    var description: String {
        return self.movie.description
    }
    
    public func getDetailViewModel() -> MovieDetailViewModel {
        return MovieDetailViewModel(movieViewModel: self)
    }
    
    public func getMovieGenres(from genres: [Genre]) -> [Genre] {
        
        let movieGenres = genres.filter { (genre) -> Bool in
            return self.movie.genres.contains(genre.id)
        }
        
        return movieGenres
    }
    
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
    
    func didTapFavorite() {
        
        movie.isFavorite = !movie.isFavorite
        
        // TODO: Persist the favorite somewhere
        
    }
    
}
