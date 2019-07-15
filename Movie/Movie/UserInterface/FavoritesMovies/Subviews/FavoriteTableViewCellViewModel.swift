//
//  FavoriteTableViewCellViewModel.swift
//  Movie
//
//  Created by Elton Santana on 15/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

class FavoriteTableViewCellViewModel {
    private var movie: Movie
    var image: UIImage!
    var name: String!
    var year: String!
    var description: String!
    
    var delegate: FavoriteTableViewCellDelegate?
    
    init(movie: Movie) {
        self.movie = movie
        self.setupComponents()
    }
    
    var movieId: Int {
        return self.movie.id!
    }
    
    func setupComponents() {
        self.name = self.movie.title!
        self.description = self.movie.overview!
        self.year = String(self.movie.releaseDate!.toDate()!.year)
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
    
    func isOnSearch(_ searchText: String) -> Bool {
        return self.movie.title!.uppercased().contains(searchText.uppercased())
        
    }
    
}
