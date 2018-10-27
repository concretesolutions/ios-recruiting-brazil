//
//  MovieGridCollectionDelegate.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

final class MovieGridCollectionDelegate: NSObject, UICollectionViewDelegate {
    
    private let interactor: MovieGridInteractor
    
    init(interactor: MovieGridInteractor) {
        self.interactor = interactor
        
        self.interactor.fetchMovieList(page: 1)
    }
    
    deinit {
        print("hue")
    }
}
