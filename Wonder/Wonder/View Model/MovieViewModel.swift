//
//  MovieViewModel.swift
//  Wonder
//
//  Created by Marcelo on 07/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class MovieViewModel {
    var title : String!
    var imageName : String!
    var year : String!
    var categories : String!
    var description : String!
    
    init(results: Results) {

        self.title = results.original_title
        self.imageName = results.poster_path
        self.year = results.release_date
        self.description = results.overview
        // categories string text
        self.categories = self.genresText(results.genre_ids)
        
    }
    
    private func genresText(_ ids: [Int]) -> String {
        var outputString = String()
        var sep = String()
        for id in ids {
            outputString = outputString + sep + AppSettings.standard.getCategory(id: id)
            sep = ", "
        }
        return outputString
    }
    
    
}
