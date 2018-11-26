//
//  GenresButtonsSetDelegate.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class GenresButtonsSetDelegate: ButtonsSetDelegate {
    
    // MARK: - Properties
    
    private var presenter: FavoritesFilterPresentation
    private var genres: [Genre]
    
    // MARK: - Initializers
    
    init(presenter: FavoritesFilterPresentation, genres: [Genre]) {
        self.presenter = presenter
        self.genres = genres
    }
    
    // MARK: - ButtonsSetDelegate protocol functions
    
    func didClickButtonWith(title: String) { }
    
    func didSelecButtonWith(title: String) {
        if let genre = (self.genres.first { $0.name == title }) {
            self.presenter.didSelect(genre: genre)
        }
    }
    
    func didDeselectButtonWith(title: String) {
        if let genre = (self.genres.first { $0.name == title }) {
            self.presenter.didDeselect(genre: genre)
        }
    }
    
}
