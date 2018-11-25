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
    
    static func assembleModule() -> UIViewController
    func showDateFilter()
    func showGenreFilter()
    
    static func didSetDateFilter()
    static func didSetGenreFilter()
    
    func exitFilter()
    func doneFilter()
}

protocol FilterView {
    var presenter: FilterPresentation! { get set }
    
    func updateDateFilterIndicator(with dates: [Date])
    func updateGenreFilterIndicator(with genres: [Genre])
}

protocol FilterPresentation: class {
    var view: FilterView? { get set }
    var interactor: FilterInteractorInput! { get set }
    var router: FilterWireframe! { get set }
    
    func viewDidLoad()
    
    func didTapCancelButton()
    func didTapDoneButton()
    func didTapDateButton()
    func didTapGenreButton()
    func didSetDateFilter()
    func didSetGenreFilter()
}

protocol FilterInteractorInput: class {
    var output: FilterInteractorOutput! { get set }
    
    func getDateFilter()
    func getGenreFilter()
}

protocol FilterInteractorOutput: class {
    func didGetDateFilter(dates: [Date])
    func didGetGenreFilter(genres: [Genre])
}


