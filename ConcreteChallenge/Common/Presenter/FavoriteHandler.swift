//
//  FavoriteHandler.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/// Implements methods to handle favorite options
protocol FavoriteHandler {
    
    /**
     To be called when the user wants to change the favorites state
     - Parameter tag: A tag to get useful information about which favorite has been selected
     */
    func favoriteStateChanged(tag: Int?)
}
