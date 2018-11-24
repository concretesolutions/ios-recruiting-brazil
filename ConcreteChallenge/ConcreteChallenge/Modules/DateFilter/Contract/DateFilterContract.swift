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
    var filterRouterDelegate: FilterRouterDelegate! { get set}
    
    static func assembleModule(filterRouterDelegate: FilterRouterDelegate) -> UIViewController
    
    func exitWithDateFilter(dates: [Date])
}

protocol DateFilterView {
    var presenter: DateFilterPresentation! { get set }
    
    func showDates(dates: [Date])
}

protocol DateFilterPresentation: class {
    var view: DateFilterView? { get set }
    var interactor: DateFilterInteractorInput! { get set }
    var router: DateFilterWireframe! { get set }
    
    var datesFilter: [Date] { get set }
    
    func viewDidLoad()
    func didSelectDate(date: Date)
    func didDeselectDate(date: Date)
    func didTapSaveButton()
}

protocol DateFilterInteractorInput: class {
    var output: DateFilterInteractorOutput! { get set }
    
    func getDates()
}

protocol DateFilterInteractorOutput: class {
    func didGetDates(dates: [Date])
}


