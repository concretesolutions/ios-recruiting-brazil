//
//  Contants.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

struct Constants {
    struct Colors{
        static let yellow = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1.0)
        static let darkyellow = UIColor(red: 217/255, green: 151/255, blue: 30/255, alpha: 1.0)
        static let blue = UIColor(red: 45/255, green: 48/255, blue: 71/255, alpha: 1.0)
    }
    
    struct URL {
        static let baseURI = "https://api.themoviedb.org/3"
        static let mostPopular = "/movie/popular"
        static let movieDetail = "/movie/%d"
        static let imageURI = "https://image.tmdb.org/t/p/w185/"
    }
    
    struct Keys {
        static let MovieDB_APIKey = "6937a73b2f2a9e3e902dc37860232bc6"
        static let MyFavorites = "myfavorites"
    }
}
