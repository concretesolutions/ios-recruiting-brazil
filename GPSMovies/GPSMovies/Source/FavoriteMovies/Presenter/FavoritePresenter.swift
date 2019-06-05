//
//  FavoritePresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct FavoriteViewData {
    var favoritesMovies = [GenereViewData]()
}

struct GenereViewData {
    var nameGenere = ""
    var movies = [MovieElement]()
}

//MARK: - VIEW DELEGATE -
protocol FavoriteViewDelegate: NSObjectProtocol {
    
}

//MARK: - PRESENTER CLASS -
class FavoritePresenter {
    
    private weak var viewDelegate: FavoriteViewDelegate?
    private lazy var viewData = FavoriteViewData()
    private var dataBase: GenreDataBase!
    
    init(viewDelegate: FavoriteViewDelegate) {
        self.viewDelegate = viewDelegate
        self.dataBase = GenreDataBase()
    }
}

//MARK: - SERVICE -
extension FavoritePresenter {
    
    func getFavoriteMovies() {
        
    }
    
}

//MARK: - UX METHODS -
extension FavoritePresenter {
    
}

//MARK: - DATABASE -
extension FavoritePresenter {
    
}
