//
//  GenreFilterPresenter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class GenreFilterPresenter: GenreFilterPresentation, GenreFilterInteractorOutput {
    
    // MARK: - Properties
    var view: GenreFilterView?
    var interactor: GenreFilterInteractorInput!
    var router: GenreFilterWireframe!
    
    var genresFilter: [Genre] = []
    
    // MARK: - GenreFilterPresentation functions
    func viewDidLoad() {
        self.interactor.getGenres()
    }
    
    func didSelectGenre(genre: Genre) {
        self.genresFilter.append(genre)
    }
    
    func didDeselectGenre(genre: Genre) {
        self.genresFilter.removeAll { (genreFromArray) -> Bool in
            genreFromArray.id == genre.id
        }
    }
    
    func didTapSaveButton() {
        self.interactor.saveGenreFilter(genres: self.genresFilter)
    }
    
    // MARK: - GenreFilterInteractorOutput functions
    func didGetGenres(genres: [Genre]) {
        self.view?.showGenres(genres: genres)
    }

}
