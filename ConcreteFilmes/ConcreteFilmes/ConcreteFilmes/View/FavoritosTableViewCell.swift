//
//  FavoritosTableViewCell.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 11/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit

class FavoritosTableViewCell: UITableViewCell {

    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelAno: UILabel!
    @IBOutlet weak var activitity: UIActivityIndicatorView!
    
    var filmeId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func confiqureCarCell(item: Filme){
        self.imagemFilme.image = UIImage(named: item.image)
        self.labelTitulo.text = item.titulo
        self.labelAno.text = item.ano
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
