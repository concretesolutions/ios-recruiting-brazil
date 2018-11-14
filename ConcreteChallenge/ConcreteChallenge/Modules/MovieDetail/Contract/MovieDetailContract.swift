//
//  MovieDetailContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol MovieDetailWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: MovieDetailPresentation! { get set }
    
    static func assembleModule() -> UIViewController
}

protocol MovieDetailView {
    var presenter: MovieDetailPresentation! { get set }
}

protocol MovieDetailPresentation: class {
    var view: MovieDetailView? { get set }
    var interactor: MovieDetailInteractorInput! { get set }
    var router: MovieDetailWireframe! { get set }
    
    func viewDidLoad()
}

protocol MovieDetailInteractorInput: class {
    var output: MovieDetailInteractorOutput! { get set }
}

protocol MovieDetailInteractorOutput: class {
}


