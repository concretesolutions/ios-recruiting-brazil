//
//  FavoriteTableViewCell.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 26/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with movie: MovieResponse) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate?.getYearFromDate()
        descLabel.text = movie.overview
        
        downloadImage(from: movie)
    }
    
    private func downloadImage(from movie: MovieResponse) {
        let endPoint = "\(API.ImageSize.w200.rawValue)\(movie.posterPath ?? "")"
        if let url = URL(string: endPoint, relativeTo: API.imageUrlBase) {
            movieImage.af_setImage(withURL: url)
        }
    }
}
