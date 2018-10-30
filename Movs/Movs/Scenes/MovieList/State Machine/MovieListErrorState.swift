//
//  MovieListErrorState.swift
//  Movs
//
//  Created by Ricardo Rachaus on 29/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieListErrorState: State {
    
    var viewController: MovieListViewController
    
    init(viewController: MovieListViewController) {
        self.viewController = viewController
        super.init()
    }
    
    override func didEnter(from previousState: State?) {
        if !(previousState is MovieListDisplayState) {
            return
        }
        if let error = viewController.viewError {
            viewController.errorView.error(viewError: error)
            viewController.collectionView.isHidden = true
            viewController.errorView.isHidden = false
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
