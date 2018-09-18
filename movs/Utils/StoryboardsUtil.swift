//
//  StoryboardsUtil.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

enum StoryboadsUtil {
    enum Movies {
        static let main = UIStoryboard(name: "Movies", bundle: nil)
        static let myFavorite = UIStoryboard(name: "MyFavorite", bundle: nil)
    }
    
    enum Favorite {
        static let main = UIStoryboard(name: "Favorite", bundle: nil)
    }
}
