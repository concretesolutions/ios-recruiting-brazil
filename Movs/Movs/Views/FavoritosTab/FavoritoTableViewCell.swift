//
//  FavoritoTableViewCell.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation
import UIKit

class FavoritoTableViewCell: UITableViewCell {

    @IBOutlet weak var capa: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var estrelas: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var generos: UILabel!
    
    var capaUrl: String?
    var buscarImagem: BuscarImagemUseCase?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descricao.sizeToFit()
    }
}
