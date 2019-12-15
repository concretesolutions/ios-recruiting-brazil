//
//  MovieCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

protocol MovieCoordinator {
    func didSelectItem(movie: Movie)
    func didFavoriteItem(movie: Movie)
}
