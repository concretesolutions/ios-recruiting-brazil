//
//  HomeTabItem.swift
//  DataMovie
//
//  Created by Andre on 12/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

enum HomeTabItem {
    
    case movieList
    
    var title: String {
        switch self {
        case .movieList:
            return "Watch list"
        }
    }
    
    var image: UIImage {
        switch self {
        case .movieList:
            return #imageLiteral(resourceName: "ic_tab_movie")
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .movieList:
            return ListMoviesWireframe().viewController
        }
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: self.title, image: self.image, selectedImage: self.image)
    }
    
}
