//
//  FavoriteCellButtonDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 24/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

protocol FavoriteCellButtonDelegate: class {
    func didPressButton(withFavoriteStatus shouldFavorite:Bool)
}
