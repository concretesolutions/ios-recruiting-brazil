//
//  FavoritosCell.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class FavoritosCell: UITableViewCell {
    @IBOutlet var imgView:UIImageView?
    @IBOutlet var progress:UIActivityIndicatorView?
    @IBOutlet var titleLb:UILabel?
    @IBOutlet var anoLb:UILabel?
    @IBOutlet var instrucao:UILabel?
    
    public func configure(with movie: Movie) {
        self.progress?.startAnimating()
        let url = Endpoints.shared.imageBaseUrl + "w154" + movie.posterPath
        imgView?.load(url: url) {
            self.progress?.isHidden = true
        }
        titleLb?.text = movie.title
        anoLb?.text = formatarData(valor: movie.releaseDate, formatoAtual: "yyyy-MM-dd", formatoNovo: "yyyy")
    }

}
