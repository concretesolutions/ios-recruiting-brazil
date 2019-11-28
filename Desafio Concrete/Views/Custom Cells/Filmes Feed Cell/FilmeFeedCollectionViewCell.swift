//
//  FilmeFeedCollectionViewCell.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

class FilmeFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var nomeFilme: UILabel!
    @IBOutlet weak var btFavorito: UIButton!
    
    func setupCell(filme: Filme){
        nomeFilme.text = filme.filmeDecodable.title
        imagemFilme.image = filme.posterUIImage
        
        if RequestFavoritos().verificarFavorito(id: filme.filmeDecodable.id ?? 0, filme: filme) != -1 {
            let image = #imageLiteral(resourceName: "favorite_full_icon")
            btFavorito.setBackgroundImage(image, for: .normal)
        }else{
            let image = #imageLiteral(resourceName: "favorite_gray_icon")
            btFavorito.setBackgroundImage(image, for: .normal)
        }
    }
    
}
