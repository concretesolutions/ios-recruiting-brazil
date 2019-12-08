//
//  FilmeFeedCollectionViewCell.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit
import CoreData

class FilmeFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var nomeFilme: UILabel!
    @IBOutlet weak var btFavorito: UIButton!
    
    func setupCell(filme: Filme, context: NSManagedObjectContext){
        nomeFilme.text = filme.filmeDecodable.title
        imagemFilme.image = filme.posterUIImage
        var image = UIImage()
        
        if RequestFavoritos(context: context).pegarFavoritoPorId(id: filme.filmeDecodable.id ?? 0) != nil {
            image = #imageLiteral(resourceName: "favorite_full_icon")
        }else{
            image = #imageLiteral(resourceName: "favorite_gray_icon")
        }
        btFavorito.setBackgroundImage(image, for: .normal)
    }
    
}
