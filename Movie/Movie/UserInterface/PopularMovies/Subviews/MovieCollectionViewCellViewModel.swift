//
//  MovieCollectionViewCellViewModel.swift
//  Movie
//
//  Created by Elton Santana on 10/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCellViewModel {
    var movie: Movie
    var image: UIImage!
    var name: String!
    var isFavorited: Bool!
    var delegate: MovieCollectionViewCellDelegate?
    
    init(movie: Movie) {
        self.movie = movie
        self.setupComponents()
    }
    
    var movieId: Int {
        return self.movie.id!
    }
    
    func setupComponents() {
        self.name = self.movie.title!
        self.isFavorited = DataProvider.shared.favoritesProvider.isFavorite(self.movie.id!)
        UIImage.loadFrom(self.movie.backdropPath!, completion: { (image, error) in
            if let error = error {
                print("Could not fetch image")
                print(error.localizedDescription)
            } else if let image = image {
                self.image = image
                self.delegate?.setupCell()
                
            }
            
        })
    }
    
    func handleFavoriteAction() {
        if self.isFavorited,
            let id = self.movie.id {
            let result = DataProvider.shared.favoritesProvider.delete(withId:id)
            self.isFavorited = result.contains(id)
        } else if let id = self.movie.id {
            let result = DataProvider.shared.favoritesProvider.addNew(withId: id)
            self.isFavorited = result.contains(id)
        }
        
        self.delegate?.updateUIFavoriteState()
    }
    
    func isOnSearch(_ searchText: String) -> Bool {
        return self.movie.title!.uppercased().contains(searchText.uppercased())
        
    }
    
    
}
