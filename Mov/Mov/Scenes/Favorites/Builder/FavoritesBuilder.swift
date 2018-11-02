//
//  FavoritesBuilder.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

class FavoritesBuilder {
    static func build() -> FavoritesViewController {
        let vc = FavoritesViewController()
        let presenter = DefaultFavoritesPresenter(viewOutput: vc)
        let interactor = DefaultFavoritesInteractor(presenter: presenter, persistence: favoritesPersistence)
        vc.interactor = interactor
        
        return vc
    }
    
    private static let favoritesPersistence: FavoritesPersistence = UserDefaultsGateway()
}
