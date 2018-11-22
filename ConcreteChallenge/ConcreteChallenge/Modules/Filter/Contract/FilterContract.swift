//
//  FilterContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol FilterWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: FilterPresentation! { get set }
    
    static func assembleModule(with movie: Movie) -> UIViewController
}

protocol FilterView {
    var presenter: FilterPresentation! { get set }
}

protocol FilterPresentation: class {
    var view: FilterView? { get set }
    var interactor: FilterInteractorInput! { get set }
    var router: FilterWireframe! { get set }
    
    func viewDidLoad()
}

protocol FilterInteractorInput: class {
    var output: FilterInteractorOutput! { get set }
}

protocol FilterInteractorOutput: class {
}


