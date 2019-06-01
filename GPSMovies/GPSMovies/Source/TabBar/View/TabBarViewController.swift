//
//  TabBarViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: OUTLETS
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: TabBarPresenter!
    private lazy var viewData:TabBarViewData = TabBarViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension TabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TabBarPresenter(viewDelegate: self)
    }
}

//MARK: - DELEGATE PRESENTER -
extension TabBarViewController: TabBarViewDelegate {

}

//MARK: - AUX METHODS -
extension TabBarViewController {

}
