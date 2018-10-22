//
//  FilterPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol FilterPresenterView: ViewProtocol {
}

final class FilterPresenter: FilterViewPresenter {
    
    unowned let view:FilterPresenterView
    unowned let coordinator:Coordinator
    
    init(view: FilterPresenterView, coordinator: Coordinator) {
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
