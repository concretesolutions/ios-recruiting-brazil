//
//  TabBarPresenter.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import Foundation

// MARK: - STRUCT VIEW DATA -
struct TabBarViewData {
    var tabBarItems = [TabBarItem]()
}

struct TabBarItem {
    var storyboardName = ""
}

// MARK: - VIEW DELEGATE -
protocol TabBarViewDelegate: NSObjectProtocol {
    func setTabBarItems(_ viewData: TabBarViewData)
}

// MARK: - PRESENTER CLASS -
class TabBarPresenter {
    
    private weak var viewDelegate: TabBarViewDelegate?
    private var viewData = TabBarViewData()
    
    init(viewDelegate: TabBarViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

// MARK: - AUX METHODS -
extension TabBarPresenter {
    func getTabBarItems() {
        self.viewData.tabBarItems = [TabBarItem]()
        self.setTabBarItems()
    }
    
    private func setTabBarItems() {
        self.viewData.tabBarItems.append(TabBarItem(storyboardName: "Home"))
        self.viewData.tabBarItems.append(TabBarItem(storyboardName: "Favorites"))
        self.viewDelegate?.setTabBarItems(self.viewData)
    }
}
