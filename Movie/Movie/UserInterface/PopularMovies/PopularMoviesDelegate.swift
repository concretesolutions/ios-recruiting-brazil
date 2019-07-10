//
//  PopularMoviesDelegate.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

protocol PopularMoviesDelegate {
    func updateCellsViewModels(_ cellsViewModels:[MovieCollectionViewCellViewModel])
}
