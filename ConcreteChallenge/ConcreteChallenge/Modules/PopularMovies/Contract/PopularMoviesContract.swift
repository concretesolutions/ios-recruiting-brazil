//
//  PopularMoviesContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol PopularMoviesWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: PopularMoviesPresentation! { get set }
    
    static func assembleModule() -> UIViewController
}

protocol PopularMoviesView {
    var presenter: PopularMoviesPresentation! { get set }
}

protocol PopularMoviesPresentation: class {
    var view: PopularMoviesView? { get set }
    var interactor: PopularMoviesInteractorInput! { get set }
    var router: PopularMoviesWireframe! { get set }
    
    func viewDidLoad()
}

protocol PopularMoviesInteractorInput: class {
    var output: PopularMoviesInteractorOutput! { get set }
}

protocol PopularMoviesInteractorOutput: class {
    
}


