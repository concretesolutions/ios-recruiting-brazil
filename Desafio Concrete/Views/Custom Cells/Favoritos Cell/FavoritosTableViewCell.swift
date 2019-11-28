//
//  FavoritosTableViewCell.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 27/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

class FavoritosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var anoFilme: UILabel!
    @IBOutlet weak var descricaoFilme: UILabel!
    @IBOutlet weak var nomeFilme: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
