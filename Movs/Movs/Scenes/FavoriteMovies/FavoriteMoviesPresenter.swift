//
//  FavoriteMoviesPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol FavoriteMoviesPresenterView: ViewProtocol {
}

final class FavoriteMoviesPresenter: FavoriteMoveisViewPresenter {
    
    unowned let view:FavoriteMoviesPresenterView
    unowned let coordinator:Coordinator
    
    init(view: FavoriteMoviesPresenterView, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        self.view.setupOnce()
    }
    
    func viewWillAppear() {
        self.view.setupWhenAppear()
    }
}
