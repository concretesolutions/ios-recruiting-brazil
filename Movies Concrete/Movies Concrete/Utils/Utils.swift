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
  static let colorDetail = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1058823529, alpha: 1)
  static let colorSmallDetail = #colorLiteral(red: 0.9767984748, green: 0.8299098611, blue: 0.3731835485, alpha: 1)
  static let colorBackground = #colorLiteral(red: 0.1622036099, green: 0.1622084081, blue: 0.1622058451, alpha: 1)
  static let colorWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  static let colorGray = #colorLiteral(red: 0.08143205196, green: 0.08118005842, blue: 0.08163464814, alpha: 1)
}

