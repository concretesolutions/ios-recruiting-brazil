//
//  MovieDetailSecondSectionTableViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MovieDetailsGenreTableViewCell: UITableViewCell {
    
    static func fileName() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "movieGenreCell"
    }
    
    @IBOutlet weak var lblGenre: UILabel!
    
    func setup(with item: Movie, checking genres: [Genre]) {
        var genresString: [String] = []
        for genre in genres where item.genreIds.contains(genre.id) {
            genresString.append(genre.name)
        }
        
        var genresDescribed: String = ""
        for genre in genresString {
            if genre == genresString.last {
                genresDescribed += "\(genre)"
            } else {
                genresDescribed += "\(genre), "
            }
        }
        self.lblGenre.text = genresDescribed
    }
}
