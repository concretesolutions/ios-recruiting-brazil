//
//  FilmesDetalhesViewController.swift
//  Movs
//
//  Created by Gabriel Coutinho on 02/12/20.
//

import Foundation
import UIKit

class FilmesDetalhesViewController: UIViewController {
    @IBOutlet weak var fundoImage: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var lancamentoEGenerosLabel: UILabel!
    @IBOutlet weak var estrelasLabel: UILabel!
    
    var titulo: String?
    var descricao: String?
    var fundoImagemPath: String?
    var generos: [String] = []
    var lancamento: Date?
    var estrelas: Float?
    
    let buscarImagem: BuscarImagemUseCase = BuscarImagem()
    
    override func viewDidLoad() {
        tituloLabel.text = titulo
        descricaoLabel.text = descricao
        descricaoLabel.sizeToFit()
        let estrelasString = estrelas != nil ? String(estrelas!) : "?"
        estrelasLabel.text = "\(estrelasString)/10"
        
        let data = formatarData(lancamento)
        let generosJoined = generos.joined(separator: "; ")
        lancamentoEGenerosLabel.text = "\(data) · \(generosJoined)"
        
        self.fundoImage.showAnimatedGradientSkeleton()
        
        self.buscarImagem.com(path: fundoImagemPath ?? "") { media in
            if let data = media {
                self.fundoImage.image = UIImage(data: data)
            } else {
                self.fundoImage.image = UIImage(named: "movie_placeholder")
            }
            self.fundoImage.hideSkeleton()
            self.fundoImage.addGradientBottomMask()
        }
    }
    
    private func formatarData(_ data: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return data != nil ? formatter.string(from: data!) : "?"
    }
    
}
