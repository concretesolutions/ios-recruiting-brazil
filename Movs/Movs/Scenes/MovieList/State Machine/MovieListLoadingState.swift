//
//  MovieListLoadingState.swift
//  Movs
//
//  Created by Ricardo Rachaus on 29/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieListLoadingState: State {
    
    var viewController: MovieListViewController
    
    init(viewController: MovieListViewController) {
        self.viewController = viewController
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
}
