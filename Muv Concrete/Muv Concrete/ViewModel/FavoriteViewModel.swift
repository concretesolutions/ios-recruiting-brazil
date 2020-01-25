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
    
    public func readCoreData(completionHandler: @escaping (Bool) -> Void) {
        let coreData = CoreData()
        if coreData.getElementCoreData() != nil {
            arrayMovies = coreData.getElementCoreData()!
            completionHandler(true)
        }
        
    }

    
    public func getMovie(indexPath: IndexPath) -> MovieCoreData {
        return arrayMovies[indexPath.row]
    }
}
