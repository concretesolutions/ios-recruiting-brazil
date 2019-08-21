//
//  PopularesCell.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class PopularesCell: UICollectionViewCell {
    @IBOutlet var img: UIImageView?
    @IBOutlet var favoriteIcon: UIImageView?
    @IBOutlet var favoriteIconView: UIView?
    @IBOutlet var nomeTv: UILabel?
    @IBOutlet var progress: UIActivityIndicatorView?
    
    public func configure(with movie: Movie, index: Int) {
        self.progress?.startAnimating()
        self.favoriteIcon?.isHidden = true
        self.favoriteIconView?.isHidden = true
        let url = Endpoints.shared.imageBaseUrl + "w154" + movie.posterPath
        if movie.posterImage == nil {
            img?.load(url: url) {
                Singleton.shared.populares[index].posterImage = self.img?.image
                self.progress?.isHidden = true
                self.showFavorite(id: movie.id)
            }
        } else {
            img?.image = Singleton.shared.populares[index].posterImage
            showFavorite(id: movie.id)
            self.progress?.isHidden = true
        }
        nomeTv?.text = movie.title + formatarData(valor: movie.releaseDate, formatoAtual: "yyyy-MM-dd", formatoNovo: ", yyyy")
    }
    
    private func showFavorite(id: Int) {
        if Singleton.shared.isFavorite(id: id) {
            favoriteIcon?.isHidden = false
            favoriteIconView?.isHidden = false
        }
    }
}
