//
//  FavoritesPresentationLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FavoritesPresentationLogic {
    /**
     Present movies requested.
     
     - parameters:
         - response: Resposne of the movies requested.
     */
    func present(response: Favorites.Response)
}
