//
//  MovsCollectionViewCell.swift
//  Movs
//
//  Created by Filipe on 17/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class MovsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "placeholder")
        activityIndicator.hidesWhenStopped = true
    }
    
    func setCell(with movie: Movie?) {
        if let movie = movie {
            
            titleLabel?.text = movie.title
            imageView.loadImageWithUrl(posterUrl: movie.posterUrl) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    print("Erro ao baixar imagem: \(error.reason)")
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.imageView.image = response.banner
                    }
                }
            }
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    
    
}
