//
//  FavoritesBaseState.swift
//  Mov
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesBaseState: ViewState {
    
    unowned let favoritesView: FavoritesView
    
    init(favoritesView: FavoritesView) {
        self.favoritesView = favoritesView
    }
    
    func hideViews() -> [UIView] {
        return []
    }
    
    func showViews() -> [UIView] {
        return []
    }
    
    func onEnter() {
        //
    }
    
    func onExit() {
        //
    }
}

