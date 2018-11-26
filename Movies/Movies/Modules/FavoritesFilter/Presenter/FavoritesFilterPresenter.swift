//
//  FavoritesFilterPresenter.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesFilterPresenter: FavoritesFilterPresentation, FavoritesFilterInteractorOutput {
    
    // MARK: - Properties
    
    weak var view: FavoritesFilterView?
    var router: FavoritesFilterWireframe!
    var interactor: FavoritesFilterUseCase!
    private var currentAddedGenres: [Genre] = []
    private var currentRemovedGenres: [Genre] = []
    private var currentAddedYears: [Int] = []
    private var currentRemovedYears: [Int] = []
    
    // MARK: - Aux functions
    
    private func applyFilters() {
        self.currentAddedGenres.forEach { self.interactor.add(genre: $0) }
        self.currentAddedYears.forEach { self.interactor.add(year: $0) }
    }
    
    private func discardFilters() {
        self.currentRemovedGenres.forEach { self.interactor.remove(genre: $0) }
        self.currentRemovedYears.forEach { self.interactor.remove(year: $0) }
    }
    
    // MARK: - FavoritesFilterPresentation protocol functions
    
    func viewDidLoad() {
        self.interactor.getGenres()
    }
    
    func didSelect(genre: Genre) {
        self.currentAddedGenres.append(genre)
    }
    
    func didDeselect(genre: Genre) {
        self.currentRemovedGenres.append(genre)
    }
    
    func didSelect(year: Int) {
        self.currentAddedYears.append(year)
    }
    
    func didDeselect(year: Int) {
        self.currentRemovedYears.append(year)
    }
    
    func didPressFilterButton() {
        self.applyFilters()
        self.router.dismiss()
    }
    
    func didPressCancelButton() {
        self.discardFilters()
        self.router.dismiss()
    }
    
    func didSetGenresSection() {
        self.interactor.getYears()
    }
    
    // MARK: - FavoritesFilterInteractorOutput protocol functions
    
    func didGet(genres: [GenreFilterItem]) {
        DispatchQueue.main.async {
            self.view?.set(genres: genres)
        }
    }
    
    func didGet(years: [YearFilterItem]) {
        print("did get years: \(years)")
        DispatchQueue.main.async {
            self.view?.set(years: years)
        }
    }
    
}
