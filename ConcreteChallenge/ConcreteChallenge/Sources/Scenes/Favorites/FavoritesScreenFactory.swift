//
//  FavoritesScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum FavoritesScreenFactory {
    static func makeFavorites() -> UIViewController {
        let favoritesViewController = FavoritesViewController()

        return favoritesViewController
    }
}
