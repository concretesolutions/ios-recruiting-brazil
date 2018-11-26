//
//  YearsButtonsSetDelegate.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class YearsButtonsSetDelegate: ButtonsSetDelegate {
    
    // MARK: - Properties
    
    private var presenter: FavoritesFilterPresentation
    
    // MARK: - Initializers
    
    init(presenter: FavoritesFilterPresentation) {
        self.presenter = presenter
    }
    
    // MARK: - ButtonsSetDelegate protocol functions
    
    func didClickButtonWith(title: String) { }
    
    func didSelecButtonWith(title: String) {
        if let year = Int(title) {
            self.presenter.didSelect(year: year)
        }
    }
    
    func didDeselectButtonWith(title: String) {
        if let year = Int(title) {
            self.presenter.didDeselect(year: year)
        }
    }
    
}
