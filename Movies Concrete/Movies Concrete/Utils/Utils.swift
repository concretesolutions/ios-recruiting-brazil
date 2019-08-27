//
//  Utils.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

struct API {
  static let API_URL = "https://api.themoviedb.org/3/"
  static let API_KEY = "6588efef941f4b27b7551299b18d9e67"
  static let API_PATH_MOVIES =  API.API_URL + "movie/popular?api_key=" + API.API_KEY + "&page="
  static let API_PATH_GENRE =  API.API_URL + "genre/movie/list?api_key=" + API.API_KEY
  static let API_PATH_MOVIES_IMAGE =  "http://image.tmdb.org/t/p/w780/"
  
}

struct Colors {
  static let colorDetail = #colorLiteral(red: 0.9767984748, green: 0.8299098611, blue: 0.3731835485, alpha: 1)
  static let colorBackground = #colorLiteral(red: 0.161847204, green: 0.1613378525, blue: 0.1622509658, alpha: 1)
  static let colorWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  static let colorRed = #colorLiteral(red: 0.8588235294, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
}

