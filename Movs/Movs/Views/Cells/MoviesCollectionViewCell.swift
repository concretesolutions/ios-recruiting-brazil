//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Gustavo Caiafa on 16/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var imgFavorito: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var viewFavorito: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configuraCell(movie : MoviesModel){
        if let titulo = movie.Titulo {
            self.lblTitulo.text = titulo
        }
        
        if let linkFoto = movie.linkFoto, movie.linkFoto != nil && movie.linkFoto != ""{
            let urlFoto = URL(string: "http://image.tmdb.org/t/p/w342\(linkFoto)")
            self.imgFoto.sd_imageIndicator = SDWebImageProgressIndicator.default
            self.imgFoto.sd_setImage(with: urlFoto)
        }
        
        if(movie.isFavorito){
            self.imgFavorito.image = UIImage(named: "favorite_full_icon")
        }
        else{
            self.imgFavorito.image = UIImage(named: "favorite_gray_icon")
        }
        
        viewFavorito.arredondaView()
    }
}
