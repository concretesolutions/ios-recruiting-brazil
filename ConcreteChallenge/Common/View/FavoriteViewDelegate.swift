//
//  FavoriteViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/// Implements view methods to update favorite status
protocol FavoriteViewDelegate: NSObjectProtocol {
    /// Set the favorite state when it has changed
    func setFavorite(_ isFavorite: Bool, tag: Int?)
}
