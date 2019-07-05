//
//  Constants.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ Success: Bool, _ errorMessage :String?) -> ()

// URL Constants
let SEARCH_URL = "https://api.themoviedb.org/3/search/movie?api_key=d27ffb8c19b10c648282cde73175e74a&query="
let URL_NOWPLAYING = "https://api.themoviedb.org/3/movie/now_playing?api_key=d27ffb8c19b10c648282cde73175e74a&language=pt-BR"
let BASE_URL = "https://api.themoviedb.org/3/movie/popular?api_key=d27ffb8c19b10c648282cde73175e74a&language=en-US&page=1"
let URL_IMG = "https://image.tmdb.org/t/p/w500"

//Segues
let TO_DETAIL = "toDetail"
let TO_FAVORITES = "toFavorites"

// Movies Defaults
let TITLE = "title"
let POSTER_PATH = "poster_path"
let RELEASE_DATE = "release_date"
let GENRE_IDS = "genre_ids"
let OVERVIEW = "overview"
let USER_NAME = "userName"
let IMG = "Img"


// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json"
]

