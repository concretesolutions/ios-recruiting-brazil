//
//  FavoritesFlowController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class FavoritesFlowController: UINavigationController {

    private lazy var moviesListVC = FavoritesListViewController()
    private var movieService: MovieServiceProtocol
    
    init(withService service: MovieServiceProtocol) {
        self.movieService = service
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = [self.moviesListVC]
        
        self.navigationBar.barTintColor = UIColor.appYellow
        self.navigationBar.tintColor = UIColor.appDarkBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
