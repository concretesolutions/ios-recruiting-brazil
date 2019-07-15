//
//  MovieCollectionViewCellDelegate.swift
//  Movie
//
//  Created by Elton Santana on 10/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

protocol MovieCollectionViewCellDelegate {
    func setupCell()
    func updateUIFavoriteState()
}
