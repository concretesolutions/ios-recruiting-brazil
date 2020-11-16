//
//  FilmeCollectionViewCell.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 08/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit

class FilmeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var butonFavorito: UIButton!
    @IBOutlet weak var activitity: UIActivityIndicatorView!
    
    var filmeId = ""
    var filmeImage = ""
    //weak var delegate: FirstViewController? //updateCustomCell?
    
    func configuraCelula(filme: Filme) {
        
        labelTitulo.text = filme.titulo
        imagemFilme.image = UIImage(named: filme.image)
        filmeId = filme.id
        filmeImage = filme.image
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        self.layer.cornerRadius = 8
    }
    
    @IBAction func makeFavorite(sender: UIButton) {
        FavoritoViewModel.shared.setFavorite(favorite: self.filmeId)
        
        if (butonFavorito.currentImage == UIImage(named: "favorite_gray_icon.png")) {
            butonFavorito.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
        }
    }
}
