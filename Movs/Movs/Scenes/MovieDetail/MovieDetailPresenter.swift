//
//  MovieDetailPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

import Foundation

protocol MovieDetailPresenterView: ViewProtocol {
}

final class MovieDetailPresenter: MovieDetailViewPresenter {
    
    unowned let view:MovieDetailPresenterView
    unowned let coordinator:Coordinator
    
    init(view:MovieDetailPresenterView, coordinator:Coordinator) {
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
