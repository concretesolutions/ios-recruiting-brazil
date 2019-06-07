//
//  Constants.swift
//  Cineasta
//
//  Created by Tomaz Correa on 04/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

public struct Constants {
    
    public struct Colors {
        public static let selectedAsFavorite = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.0)
        public static let unselectedAsFavorite = UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1.0)
    }
    
    public struct Segues {
        public static let showHome = "showHome"
        public static let showMovieDetail = "showMovieDetail"
    }
    
    public struct Hosts {
        public static let movieAPI = "https://api.themoviedb.org/3"
        public static let moviePoster = "https://image.tmdb.org/t/p/w185_and_h278_bestv2"
        public static let movieBackdrop = "https://image.tmdb.org/t/p/w1400_and_h450_face"
    }
    
    public struct Paths {
        public static let popularMovies = "/movie/popular"
        public static let genres = "/genre/movie/list"
    }
    
    public struct Service {
        public static let apiKey = "7cb7b039773c73e5e75191bbd4c1d8a4"
    }
    
    public struct Cells {
        public static let movieTableViewCell = "MovieTableViewCell"
        public static let loadingTableViewCell = "LoadingTableViewCell"
    }
    
    public struct UserDefaultsKey {
        public static let favoriteList = "FavoriteList"
        public static let genres = "Genres"
    }
}
