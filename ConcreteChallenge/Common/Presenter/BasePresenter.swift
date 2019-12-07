//
//  BasePresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

class BasePresenter: Presenter {
    
    // MARK: - Properties -
    private(set) weak var view: ViewDelegate?
    
    // MARK: - Init -
    init() {
        guard type(of: self) != BasePresenter.self else {
            fatalError(
                "Creating `BasePresenter` instances directly is not supported. This class is meant to be subclassed."
            )
        }
    }
    
    // MARK: - Methods -
    func attachView(_ view: ViewDelegate) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
}
