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
    
    var datesFilter: [Date] = []
    
    // MARK: - GenreFilterPresentation functions
    func viewDidLoad() {
        
    }
    
    func didSelectGenre(genre: Genre) {
    }
    
    func didDeselectGenre(genre: Genre) {
    }
    
    func didTapSaveButton() {
    }
    
    // MARK: - GenreFilterInteractorOutput functions
    func didGetGenres(genres: [Genre]) {
        
    }

}
