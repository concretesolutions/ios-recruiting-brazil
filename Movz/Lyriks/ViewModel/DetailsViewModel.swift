//
//  DetailsViewModel.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 01/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class DetailsViewModel {
    let id:String
    let overview:NSAttributedString
    let release:NSAttributedString
    let voteAverage:NSAttributedString
    var favorite:Bool = false
    var genres:NSAttributedString
    private let model:Movie
    init(movie:Movie){
        self.genres = NSAttributedString(string: "No genrer", attributes: Typography.description(Color.scarlet).attributes())
        self.model = movie
        self.id  = movie.id
        
        overview = NSAttributedString(string: "    \(movie.overview)\n" , attributes: Typography.description(.black).attributes())
        let date = movie.release_date
        var fixDate = date.split(separator: "-")
        fixDate.reverse()
        let releaseString = NSMutableAttributedString(string: "releases in ", attributes: Typography.description(Color.black).attributes())
        releaseString.append(NSAttributedString(string: "\(fixDate.joined(separator: "-"))", attributes: Typography.description(Color.scarlet).attributes()))
        release
         = releaseString
        
        let voteString =  NSMutableAttributedString(string: "Review:", attributes: Typography.description(Color.black).attributes())
        voteString.append(NSAttributedString(string:String(movie.vote_average),attributes:Typography.description(Color.scarlet).attributes()))
        voteAverage = voteString
        self.retrieveGenres(array: movie.genres)
        
    }
 
    /**
     Convert array de genre ids to string with text options
     */
    func retrieveGenres(array:[Int]){
        let string = NSMutableAttributedString()
        string.append(NSAttributedString(string: "Genres \n", attributes: Typography.description(Color.black).attributes()))
        for element in array{
            let index = MovieAPI.genre.first { (genre) -> Bool in
                return genre.id == element
            }
            guard let indexNonNil = index else{return}
            string.append(NSAttributedString(string: "\(indexNonNil.name)\n", attributes: Typography.description(Color.scarlet).attributes()))
        }
        self.genres = string
        
        
    }
    func getModel()->Movie{
        return self.model
    }

}
