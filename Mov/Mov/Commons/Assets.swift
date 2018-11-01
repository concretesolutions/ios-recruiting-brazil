//
//  Images.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

struct Images {
    
    static let poster_placeholder = #imageLiteral(resourceName: "poster_placeholder")
    
    // Mark: Icons
    static let isFavoriteIconFull = #imageLiteral(resourceName: "favorite_full_icon")
    static let isFavoriteIconGray = #imageLiteral(resourceName: "favorite_gray_icon")
    static let favoritesIcon = #imageLiteral(resourceName: "favorite_empty_icon")
    static let error = #imageLiteral(resourceName: "error_icon")
    static let movieListIcon = #imageLiteral(resourceName: "list_icon")
    static let noResults = #imageLiteral(resourceName: "search")
    
}

struct Colors {
    static let lightYellow = #colorLiteral(red: 0.9690945745, green: 0.8084867597, blue: 0.3556014299, alpha: 1)
    static let darkYellow = #colorLiteral(red: 0.8371319175, green: 0.5835844874, blue: 0.1119432524, alpha: 1)
    static let darkBlue = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
}

struct Texts {
    static let movieGridError = "Um erro ocorreu. Por favor, tente novamente."
    static func noResults(for request: String) -> String {
        return "Sua busca por \"\(request)\" não retornou nenhum resultado."
    }
}

struct Fonts {
    static let helveticaNeueBold = "HelveticaNeue-Bold"
    static let helveticaNeue = "HelveticaNeue"
}
