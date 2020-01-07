//
//  MovieCellViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    
    var movie: Movie
    
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
