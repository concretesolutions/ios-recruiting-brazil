//
//  FilterFavoritePresentationMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 07/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class FilterFavoritePresentationMock: FilterFavoritePresentation {
   
    var hasCalledViewDidLoad: Bool = false
    var hasCalledDidEnterFilters: Bool = false
    
    var view: FilterFavoriteView?
    var router: FilterFavoriteWireframe!
    var movies: [MovieEntity] = []
    
    func viewDidLoad() {
        hasCalledViewDidLoad = true
    }
    
    func didEnterFilters(_ filter: Dictionary<String, String>) {
        hasCalledDidEnterFilters = true
    }

}
