//
//  FavoriteMovieCell.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(movie: MovieEntity) {
        self.titleLbl.text = movie.movieTitle
        self.dateLbl.text = movie.movieDate
        self.descriptionLbl.text = movie.movieDescription
        
        let pathImage = (movie.movieImage) ?? ""
        let Image = "\(URL_IMG)\(pathImage)" ?? ""
        let url = URL(string: Image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            imageMovie.image = UIImage(data: imageData)
        }
    }

}
