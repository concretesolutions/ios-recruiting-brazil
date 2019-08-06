//
//  CollectionCellViewModel.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit


class CollectionCellViewModel{
    var image:UIImage? = UIImage(named: "image_not_found")
    let id:String
    var title:NSAttributedString
    var colors = TitleColors.normal.dictionary()
    
    private let movie:Movie
    init(movie:Movie){
        
        self.title = NSAttributedString(string:  movie.title, attributes: Typography.title(Color.black).attributes())
        self.id = movie.id
        self.movie = movie
        if(CoreDataAPI.isFavorite(id: movie.id)){
            self.image = UIImage.getSavedImage(id: movie.id)
            self.colors = TitleColors.favorite.dictionary()
        }else{
            MovieAPI.getPosterImage(width: 200, path: movie.poster_path ?? "") { (image) in
                self.image = image
                movie.image = image
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FetchImage"), object: nil)
            }
        }
        self.title = NSAttributedString(string:  movie.title, attributes: Typography.title(colors["title"] ?? Color.black).attributes())
        
        
       
       
    }

    func getMovie()->Movie{
        return movie
    }

}
