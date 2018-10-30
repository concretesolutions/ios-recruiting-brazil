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
    
    override func didEnter(from previousState: State?) {
        if !(previousState is MovieListDisplayState) {
            return
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is MovieListDisplayState.Type:
            return true
        default:
            return false
        }
    }
    
}
