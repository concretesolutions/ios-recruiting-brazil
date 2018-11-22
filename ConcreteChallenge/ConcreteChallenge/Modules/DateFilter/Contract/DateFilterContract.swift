//
//  DateFilterContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol DateFilterWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: DateFilterPresentation! { get set }
    
    static func assembleModule() -> UIViewController
}

protocol DateFilterView {
    var presenter: DateFilterPresentation! { get set }
}

protocol DateFilterPresentation: class {
    var view: DateFilterView? { get set }
    var interactor: DateFilterInteractorInput! { get set }
    var router: DateFilterWireframe! { get set }
    
    func viewDidLoad()
}

protocol DateFilterInteractorInput: class {
    var output: DateFilterInteractorOutput! { get set }
}

protocol DateFilterInteractorOutput: class {
}


