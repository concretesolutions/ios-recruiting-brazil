//
//  TabBarPresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct TabBarViewData {
    
}

//MARK: - VIEW DELEGATE -
protocol TabBarViewDelegate: NSObjectProtocol {
    
}

//MARK: - PRESENTER CLASS -
class TabBarPresenter {
    
    private weak var viewDelegate: TabBarViewDelegate?
    private lazy var viewData = TabBarViewData()
    
    init(viewDelegate: TabBarViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

//SERVICE
extension TabBarPresenter {
    
}

//AUX METHODS
extension TabBarPresenter {
    
}

//DATABASE
extension TabBarPresenter {
    
}
