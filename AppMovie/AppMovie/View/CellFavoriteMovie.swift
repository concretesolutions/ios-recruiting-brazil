//
//  CellFavoriteMovie.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 18/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable

class CellFavoriteMovie: UITableViewCell, NibReusable {
    //Mark: - Properties
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
    // MARK: - Init
    func configureCell(movie: MovieEntity) {
        self.titleLbl.text = movie.movieTitle
        self.dateLbl.text = movie.movieDate
        self.descriptionLbl.text = movie.movieDescription
        
        guard let pathImage = (movie.movieImage) else {return}
        let Image = "\(URL_IMG)\(pathImage)"
        let url = URL(string: Image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            imageMovie.image = UIImage(data: imageData)
        }
    }
    
    
}
