//
//  FavoriteHelper.swift
//  iCinetop
//
//  Created by Alcides Junior on 20/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import Foundation
class FavoriteHelper{
    static func isFavorited(_ id: Int)->Bool{
        let favoriteModel = FavoriteModel()
        let favorited = favoriteModel.thisMovieExists(id: id)
        if favorited{
            return true
        }
        return false
    }
}
