//
//  TabBarPresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation
import UIKit

enum StoryBoardNameTabBar: String {
    case movie = "Movie"
    case favorite = "Favorite"
}

enum IdentifierControllerTabBar: String {
    case movie = "movieViewController"
    case favorite = "favoriteViewController"
}

enum ImageNameTabBar: String {
    case movieEnable = "movie-enable"
    case movieDisable = "movie-disable"
    case favoriteEnable = "favorite-enable"
    case favoriteDisable = "favorite-disable"
}

enum NameItemTabBar: String {
    case movie = "Filmes"
    case favorite = "Favoritos"
}

//MARK: - STRUCT VIEW DATA -
struct TabBarViewData {
    var tabaBarItens = [TabBarItem]()
}

struct TabBarItem {
    var name = NameItemTabBar.movie
    var storyBoard = StoryBoardNameTabBar.movie
    var viewControllerIdentifier = IdentifierControllerTabBar.movie
    var imageTabBar = ImageTabBar()
}

struct ImageTabBar {
    var imageNameNormal = ImageNameTabBar.movieEnable
    var imageNameSelected = ImageNameTabBar.movieDisable
    var imageNotSelected: UIImage? {
        get {
            return UIImage(named: self.imageNameNormal.rawValue)
        }
    }
    var imageSelected: UIImage? {
        get {
            return UIImage(named: self.imageNameSelected.rawValue)
        }
    }
}

//MARK: - VIEW DELEGATE -
protocol TabBarViewDelegate: NSObjectProtocol {
    func setViewData(tabbarNewViewData: TabBarViewData)
}

//MARK: - PRESENTER CLASS -
class TabBarPresenter {
    
    private weak var viewDelegate: TabBarViewDelegate?
    private lazy var viewData = TabBarViewData()
    private lazy var itens = [NameItemTabBar]()
    
    init(viewDelegate: TabBarViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

//MARK: - SERVICE -
extension TabBarPresenter {
    func getTabBarItens() {
        self.createTabBar()
        self.viewDelegate?.setViewData(tabbarNewViewData: self.viewData)
    }
}

//MARK: - AUX METHODS -
extension TabBarPresenter {
    private func createTabBar() {
        self.viewData.tabaBarItens.removeAll()
        self.itens.removeAll()
        self.itens.append(.movie)
        self.itens.append(.favorite)
        self.itens.forEach { (menuItem) in
            self.viewData.tabaBarItens.append(self.getMenuItem(menuNameTabBar: menuItem))
        }
    }
    
    private func getMenuItem(menuNameTabBar: NameItemTabBar) -> TabBarItem {
        switch menuNameTabBar {
        case .movie:
            return self.getItemTabBar(storyBoardName: .movie, controllerId: .movie, nameMenu: .movie, imageSelectedName: .movieEnable, imageNotSelectedName: .movieDisable)
        case .favorite:
            return self.getItemTabBar(storyBoardName: .favorite, controllerId: .favorite, nameMenu: .favorite, imageSelectedName: .favoriteEnable, imageNotSelectedName: .favoriteDisable)
        }
    }
    
    private func getItemTabBar(storyBoardName: StoryBoardNameTabBar, controllerId: IdentifierControllerTabBar, nameMenu: NameItemTabBar, imageSelectedName: ImageNameTabBar, imageNotSelectedName:ImageNameTabBar) -> TabBarItem{
        let imageTabBar = ImageTabBar(imageNameNormal: imageNotSelectedName, imageNameSelected: imageSelectedName)
        return TabBarItem(name: nameMenu, storyBoard: storyBoardName, viewControllerIdentifier: controllerId, imageTabBar: imageTabBar)
    }
}
