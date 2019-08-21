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
    @IBOutlet var nomeTv: UILabel?
    @IBOutlet var progress: UIActivityIndicatorView?
    
    public func configure(with movie: Movie, index: Int) {
        self.progress?.startAnimating()
        let url = Endpoints.shared.imageBaseUrl + "w154" + movie.posterPath
        if movie.posterImage == nil {
            img?.load(url: url) {
                Singleton.shared.populares[index].posterImage = self.img?.image
                self.progress?.isHidden = true
            }
        } else {
            img?.image = Singleton.shared.populares[index].posterImage
        }
        nomeTv?.text = movie.title + formatarData(valor: movie.releaseDate, formatoAtual: "yyyy-MM-dd", formatoNovo: ", yyyy")
    }
}
