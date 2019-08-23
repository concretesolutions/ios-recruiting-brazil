//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Gustavo Caiafa on 21/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import SDWebImage

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuraCell(favoritesModel : MoviesModelLocal){
        if let titulo = favoritesModel.Titulo{
            self.lblTitulo.text = titulo
        }
        
        if let descricao = favoritesModel.Descricao{
            self.lblDescricao.text = descricao
        }
        
        if let data = favoritesModel.Data{
            self.lblData.text = String(data)
        }
        
        if let linkFoto = favoritesModel.LinkFoto, favoritesModel.LinkFoto != nil && favoritesModel.LinkFoto != ""{
            let urlFoto = URL(string: "http://image.tmdb.org/t/p/w342\(linkFoto)")
            self.imgFoto.sd_imageIndicator = SDWebImageProgressIndicator.default
            self.imgFoto.sd_setImage(with: urlFoto)
        }
    }
}
