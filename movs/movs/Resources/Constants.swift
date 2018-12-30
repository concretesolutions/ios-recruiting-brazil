//
//  Constants.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

enum Constants {
    enum Integration {
        static let apikey = "?api_key=21b8ff9ef8b9ae187b8fd090e799fc60"
        static let baseurl = "https://api.themoviedb.org/3"
        static let popularMoviesEndpoint = "/movie/popular"
        static let genresEndpoint = "/genre/movie/list"
        static let imageurl = "http://image.tmdb.org/t/p/w185/"
    }

    enum LocalStorage {
        static let favorites = "FAVORITES_USER_DEFAULTS"
    }

    enum Notifications {
        static let updateList = "UPDATE_LIST"
    }

    enum Accessibility {
        static let favorite = "FAVORITE_ACCESSIBILITY"
    }

    enum General {
        static let errorMessage = "Oh snap, something went wrong :("
    }
}
