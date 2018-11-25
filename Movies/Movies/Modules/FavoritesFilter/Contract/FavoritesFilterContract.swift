//
//  FavoritesFilterContract.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

protocol FavoritesFilterView: class {
    
    var presenter: FavoritesFilterPresentation! { get set }
    
    func set(genres: [(genre: Genre, isSelected: Bool)])
    func set(years: [(year: Int, isSelected: Bool)])
    
}

protocol FavoritesFilterPresentation {
    
    var view: FavoritesFilterView? { get set }
    var router: FavoritesFilterWireframe! { get set }
    var interactor: FavoritesFilterUseCase! { get set }
    
    func didSelect(genre: Genre)
    func didDeselect(genre: Genre)
    func didSelect(year: Int)
    func didDeselect(year: Int)
    func didPressFilterButton()
    func didPressCancelButton()
    
}

protocol FavoritesFilterUseCase {
    
    var output: FavoritesFilterInteractorOutput! { get set }
    
    func add(genre: Genre)
    func remove(genre: Genre)
    func add(year: Int)
    func remove(year: Int)
    
}

protocol FavoritesFilterInteractorOutput { }

protocol FavoritesFilterWireframe {
    
    var view: UIViewController? { get set }
    
    func dismiss()
    
    static func assembleModule() -> UIViewController
    
}
