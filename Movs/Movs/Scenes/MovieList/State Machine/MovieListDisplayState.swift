//
//  MovieListDisplayState.swift
//  Movs
//
//  Created by Ricardo Rachaus on 29/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieListDisplayState: State {
    
    var viewController: MovieListViewController
    
    init(viewController: MovieListViewController) {
        self.viewController = viewController
        super.init()
    }
    
    override func didEnter(from previousState: State?) {
        viewController.collectionView.isHidden = false
        viewController.errorView.isHidden = true
        viewController.collectionView.reloadData()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is MovieListDisplayState.Type:
            fallthrough
        case is MovieListLoadingState.Type:
            fallthrough
        case is MovieListErrorState.Type:
            return true
        default:
            return false
        }
    }
    
}
