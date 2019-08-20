//
//  FavoriteMock.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/20/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation
import UIKit


@testable import MoviesApp

class FavoriteMock{
    var favorites = [Favorite]()
    var images = [UIImage]()
    
    init() {
        createFavorite()
        createFavorite()
    }
    
    
    func createFavorite(){
        let newFavorite = Favorite()
        let img = UIImage()
        favorites.append(newFavorite)
        images.append(img)
    }
}
