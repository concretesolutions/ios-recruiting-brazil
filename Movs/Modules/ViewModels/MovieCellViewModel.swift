// swiftlint:disable identifier_name

//
//  MovieCellViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    
    // MARK: - Properties
    
    internal let apiManager = MoviesAPIManager()
    internal let decoder = JSONDecoder()
    
    // MARK: - Attributes
    
    public let id: Int
    @Published var poster: UIImage?
    public let releaseDate: String
    public let title: String
    public let overview: String
    
    // MARK: - Initializers
    
    init(movie: MovieDTO) {
        self.id = movie.id
        self.poster = UIImage.from(color: .secondarySystemBackground)
        self.releaseDate = movie.releaseDate
        self.title = movie.title
        self.overview = movie.overview
        
        if let imagePath = movie.posterPath {
            self.requestImage(path: imagePath)
        }
    }
    
    func requestImage(path: String) {
        self.apiManager.getImage(path: path, completion: { (data, error) in
            if let data = data {
                self.poster = UIImage(data: data)
            }
        })
    }
}
