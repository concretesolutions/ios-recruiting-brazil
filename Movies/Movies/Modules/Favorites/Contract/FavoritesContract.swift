//
//  FavoritesContract.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

protocol FavoritesView: class {
    
    var presenter: FavoritesPresentation { get set }
    
}

protocol FavoritesPresentation {
    
    var view: FavoritesView? { get set }
    var router: FavoritesWireframe! { get set }
    var interactor: FavoritesUseCase! { get set }
    
}

protocol FavoritesUseCase {
    
    var output: FavoritesInteractorOutput! { get set }
    
}

protocol FavoritesInteractorOutput {
    
}

protocol FavoritesWireframe {
    
    var view: UIViewController? { get set }
    
    
    
    static func assembleModule() -> UIViewController
    
}
