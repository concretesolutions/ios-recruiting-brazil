//
//  Presenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol Presenter {
    
    /**
     The view object that conforms to a `ViewDelegate` protocol.
     
     Send the updates to the view using this property.
     */
    var view: ViewDelegate? { get }
    
    /**
     Attaches a view to be currently controlled by the presenter.
     
     - Parameter view: The view to be attached.
     */
    func attachView(_ view: ViewDelegate)
    
    /**
     Detaches the view being controlled by the presenter.
     */
    func detachView()
}
