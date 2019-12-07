//
//  ViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol ViewDelegate: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func exitView()
    func navigateToView(presenter: Presenter)
}
