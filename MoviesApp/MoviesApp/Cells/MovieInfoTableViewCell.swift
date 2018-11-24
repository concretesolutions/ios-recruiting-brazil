//
//  MovieInfoTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 19/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

enum MovieInfo{
    case releaseDate
    case avarageRating
}

class MovieInfoTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var label: UILabel!
    var movie:Movie?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with movie:Movie, genres:[Genre]){
        self.label.font = self.label.font.withSize(17.0)
        
        var genresString = ""
        
        if movie.genres.count > 0{
            for genre in genres where movie.genres.contains(genre.id){
                genresString.append("\(genre.name), ")
            }
            genresString.removeLast(2)
        }else{
            genresString = "No Genre associated with this movie"
        }
       
        self.label.text = genresString
    }
    
    func setup(with movie:Movie, row:Int){
        self.label.font = self.label.font.withSize(17.0)

        switch row{
        case 2:
            self.label.text = "Released in \(movie.year)"
        case 3:
            self.label.text = "Average Rating: \(movie.voteAverage)"
        default:
            print("Something is wrong!")
        }
    }
    
}
