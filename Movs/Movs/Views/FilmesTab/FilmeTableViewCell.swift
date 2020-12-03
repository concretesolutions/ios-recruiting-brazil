//
//  TableViewCell.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import UIKit

class FilmeTableViewCell: UITableViewCell {

    @IBOutlet weak var capa: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var estrelas: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var generos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titulo.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
