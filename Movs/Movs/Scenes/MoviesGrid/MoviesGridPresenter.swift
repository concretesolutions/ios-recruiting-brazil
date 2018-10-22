//
//  MoviesGridPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol MoviesGridPresenterView: ViewProtocol {
}

final class MoviesGridPresenter: MoviesGridViewPresenter {
    
    unowned let view:MoviesGridPresenterView
    unowned let coordinator:Coordinator
    
    init(view:MoviesGridPresenterView, coordinator: Coordinator) {
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
