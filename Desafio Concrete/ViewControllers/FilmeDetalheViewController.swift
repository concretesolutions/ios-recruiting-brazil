//
//  FilmeDetalheViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 27/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

class FilmeDetalheViewController: UIViewController {
    
    //***********************************
    //MARK: Variaveis
    //***********************************
    
    //IBOutlets
    
    @IBOutlet weak var posterFilme: UIImageView!
    @IBOutlet weak var nomeFilme: UILabel!
    @IBOutlet weak var anoFilme: UILabel!
    @IBOutlet weak var generoFilme: UILabel!
    @IBOutlet weak var descricaoFIlme: UILabel!
    @IBOutlet weak var btFavorito: UIButton!
    
    //LET e VAR
    
    var filme: Filme?

    //***********************************
    //MARK: Ciclo de vida view controller
    //***********************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    //***********************************
    //MARK: Layout
    //***********************************
    
    func setupLayout(){
        
        guard let filme = filme else { return }
        
        nomeFilme.text = filme.filmeDecodable.title ?? ""
        
        anoFilme.text = "\(FuncoesFilme.pegarAnoFilme(filme: filme))"
            
        FuncoesFilme().verificarGenerosFilme(generosID: filme.filmeDecodable.genre_ids ?? [], completion: { (generos) in
            DispatchQueue.main.async {
                self.generoFilme.text = generos.joined(separator: ",")
            }
        })
        
        descricaoFIlme.text = filme.filmeDecodable.overview ?? ""
        
        posterFilme.image = filme.posterUIImage
        
        btFavorito.addTarget(self, action:  #selector(favoritar), for: .touchUpInside)
        
        if let id = filme.filmeDecodable.id {
            if FuncoesFilme().verificarFavorito(id: id, filme: filme) == -1 {
                let image = #imageLiteral(resourceName: "favorite_gray_icon")
                btFavorito.setBackgroundImage(image, for: .normal)
            }else{
                let image = #imageLiteral(resourceName: "favorite_full_icon")
                btFavorito.setBackgroundImage(image, for: .normal)
            }
        }
        
    }
    
    @objc func favoritar(){
        
        guard let filme = filme else { return }
        
        if let id = filme.filmeDecodable.id {
            if FuncoesFilme().verificarFavorito(id: id, filme: filme) == -1 {
                let image = #imageLiteral(resourceName: "favorite_full_icon")
                btFavorito.setBackgroundImage(image, for: .normal)
            }else{
                let image = #imageLiteral(resourceName: "favorite_gray_icon")
                btFavorito.setBackgroundImage(image, for: .normal)
            }
            FuncoesFilme().salvarFilmeFavorito(id: id, filme: filme)
        }
    }

}
