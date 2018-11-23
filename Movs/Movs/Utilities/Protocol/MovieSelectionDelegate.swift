//
//  MovieSelectionDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 20/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

protocol MovieSelectionDelegate {
    func didSelect(movie:Movie)
    func unfavoriteSelected(movie:Movie, indexPath: IndexPath)
}

extension MovieSelectionDelegate {
    func unfavoriteSelected(movie:Movie, indexPath: IndexPath) {}
}
