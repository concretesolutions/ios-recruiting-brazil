//
//  FavoriteViewModel.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 24/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class FavoriteViewModel {
    
    var delegate: UIViewController?
    
    var arrayMovies: [MovieCoreData] = []
    
//    salvar os ids em um array useDefaults

    
    public func getMovie(indexPath: IndexPath) -> MovieCoreData {
        return arrayMovies[indexPath.row]
    }
}
