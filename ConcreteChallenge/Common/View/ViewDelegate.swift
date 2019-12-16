//
//  ViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol ViewDelegate: NSObjectProtocol, ErrorDelegate {
    
    /// Do the necessary steps to inform the user that the view is loading
    func startLoading()
    
    /// Do the necessary steps to inform the user that the view has stopped loading
    func finishLoading()
    
    /// Tells the view to back to the previous view
    func exitView()
    
    /**
    Tells the view to navigate to a new view controller
    
    - Parameter presenter: The presenter of the new controller
    
    This method gives a presenter to initialize the detail view, which the controller can use to navigate to the new page
    */
    func navigateToView(presenter: Presenter)
}
