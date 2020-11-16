//
//  FilmeDetalhesViewController.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 10/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FilmeDetalhesViewController: UIViewController {

    @IBOutlet weak var imagemFilme: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelAno: UILabel!
    @IBOutlet weak var labelGenero: UILabel!
    @IBOutlet weak var imageFavorito: UIImageView!
    @IBOutlet weak var activitity: UIActivityIndicatorView!
    
    var errorView = UIView()
    var filmeSelecionado: Filme? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activitity.startAnimating()
        
        let imageURL = API_URL_IMAGES + filmeSelecionado!.image
        
        Alamofire.request(imageURL).responseImage { response in
            
            if case .success(let image) = response.result {
                //print("image downloaded: \(image)")
                self.activitity.stopAnimating()
                self.imagemFilme.image = image
            }
        }
        
        let image = FavoritoViewModel.shared.changeIcoFavorite(favorite: filmeSelecionado!.id)
        self.imageFavorito.image = UIImage(named: image)
        
        self.labelTitulo.text = filmeSelecionado!.titulo
        self.labelAno.text = filmeSelecionado!.ano
        
        FilmesViewModel.shared.getGeneros(completionHandler: { results  in
            //print(results)
            
            if (results.count > 0) {
                var listaGeneros = ""
                for genero in self.filmeSelecionado!.genero {
                    
                    if (results.contains(genero as! Int)) {
                        //listaGeneros += "\(genero), "
                        FilmesViewModel.shared.getGenerosName(generoId: genero as! Int, completionHandler: { generoStr in
                            listaGeneros += "\(Help.shared.formatGenre(generos: generoStr)), "
                            self.labelGenero.text = String(listaGeneros.dropLast(2))
                        })
                    }
                }
            } else {
                //Cria view de retorno com erro.
                self.errorView = ErrorView.shared.loadView(view: self.view)
                self.view.addSubview(self.errorView)
                Help.shared.runThisAfterDelay(seconds: 3.0) {
                    self.errorView.removeFromSuperview()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
