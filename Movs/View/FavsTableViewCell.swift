//
//  FavsTableViewCell.swift
//  Movs
//
//  Created by Filipe Merli on 19/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class FavsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(with: .none)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.image = #imageLiteral(resourceName: "placeholder")
    }
    
    func setCell(with movie: FavMovie?) {
        if let movie = movie {
            titleLabel?.text = movie.title
            overviewTextView.text = movie.overview
            yearLabel.text = movie.year
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            posterImageView.loadImageWithUrl(posterUrl: movie.posterUrl!) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                    }
                    debugPrint("Erro ao baixar imagem: \(error.reason)")
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.posterImageView.image = response.banner
                    }
                }
            }
        }
    }
    
    
}
