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
        return true
    }
    
}
