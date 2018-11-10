//
//  PopularMoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class PopularMoviesPresenter: PopularMoviesPresentation, PopularMoviesInteractorOutput {
    
    // MARK: - Properties
    var view: PopularMoviesView?
    var interactor: PopularMoviesInteractorInput!
    var router: PopularMoviesWireframe!
    
    // MARK: - PopularMoviesPresentation functions
    func viewDidLoad() {
    }
    
    // MARK: - PopularMoviesInteractorOutput functions
    
}
