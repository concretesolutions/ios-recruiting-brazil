//
//  FavoriteMoviesContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol FavoriteMoviesWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: FavoriteMoviesPresentation! { get set }
    
    static func assembleModule() -> UIViewController
}

protocol FavoriteMoviesView {
    var presenter: FavoriteMoviesPresentation! { get set }
}

protocol FavoriteMoviesPresentation: class {
    var view: FavoriteMoviesView? { get set }
    var interactor: FavoriteMoviesInteractorInput! { get set }
    var router: FavoriteMoviesWireframe! { get set }
    
    func viewDidLoad()
}

protocol FavoriteMoviesInteractorInput: class {
    var output: FavoriteMoviesInteractorOutput! { get set }
}

protocol FavoriteMoviesInteractorOutput: class {
    
}


