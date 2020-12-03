//
//  FilmesDetalhesViewController.swift
//  Movs
//
//  Created by Gabriel Coutinho on 02/12/20.
//

import Foundation
import UIKit

import Alamofire
import AlamofireImage

class FilmesDetalhesViewController: UIViewController {
    @IBOutlet weak var fundoImage: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var generosLabel: UILabel!
    
    var titulo: String?
    var descricao: String?
    var fundoImagemPath: String?
    var generos: String?
    
    override func viewDidLoad() {
        tituloLabel.text = titulo
        self.fundoImage.showAnimatedGradientSkeleton()
        
        AF.request("https://image.tmdb.org/t/p/w500/\(fundoImagemPath ?? "")").responseImage { image in
            switch image.result {
            case let .success(image):
                self.fundoImage.image = image
            case let .failure(error):
                self.fundoImage.image = UIImage(named: "movie_placeholder")
                debugPrint(error)
            }
            self.fundoImage.hideSkeleton()
            self.fundoImage.addBlur()
        }
    }
    
}
