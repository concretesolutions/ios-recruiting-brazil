//
//  File.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class TableCellViewModel{
    var title:NSAttributedString
    var colors = TitleColors.normal.dictionary()
    var vote:NSAttributedString
    private let movie:Movie
    init(movie:Movie){
        
        self.title = NSAttributedString(string:  movie.title, attributes: Typography.title(Color.black).attributes())
        self.movie = movie
        if(CoreDataAPI.isFavorite(id: movie.id)){
            self.colors = TitleColors.favorite.dictionary()
        }
        self.title = NSAttributedString(string:  movie.title, attributes: Typography.title(colors["title"] ?? Color.black).attributes())
        self.vote = NSAttributedString(string:  movie.vote_average, attributes: Typography.title(colors["title"] ?? Color.black).attributes())
    }
    
    func getMovie()->Movie{
        return movie
    }
    
}

