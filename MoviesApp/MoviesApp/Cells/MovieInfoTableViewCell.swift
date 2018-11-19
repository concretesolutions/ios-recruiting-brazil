//
//  MovieInfoTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 19/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

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
        for genre in genres where movie.genres.contains(genre.id){
            genresString.append("\(genre.name), ")
        }
        
        genresString.removeLast()
        genresString.removeLast()
        
        self.label.text = genresString
    }
    
    func setup(with movie:Movie, row:Int){
        self.label.font = self.label.font.withSize(17.0)

        switch row{
        case 2:
            self.label.text = "Released in \(movie.releaseData.getYear() ?? 0001)"
        case 3:
            self.label.text = "Average Rating: \(movie.voteAverage)"
        default:
            print("Something is wrong!")
        }
    }
    
}
