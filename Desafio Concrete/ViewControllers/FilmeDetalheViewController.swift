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
    var requestFavoritos: RequestFavoritos!

    //***********************************
    //MARK: Ciclo de vida view controller
    //***********************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
        setupLayout()
    }
    
    //***********************************
    //MARK: Context
    //***********************************
    
    func setupContext(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        requestFavoritos = RequestFavoritos(context: appDelegate.persistentContainer.viewContext)
    }
    
    //***********************************
    //MARK: Layout
    //***********************************
    
    func setupLayout(){
        
        guard let filme = filme else { return }
        
        setupLabels(filme: filme)
        
        btFavorito.addTarget(self, action:  #selector(favoritar), for: .touchUpInside)
        
        if let id = filme.filmeDecodable.id {
            setupImagemBotao(id: id, imagem1: #imageLiteral(resourceName: "favorite_gray_icon"), imagem2: #imageLiteral(resourceName: "favorite_full_icon"))
        }
        
    }
    
    func setupLabels(filme: Filme){
        nomeFilme.text = filme.filmeDecodable.title ?? ""
        
        anoFilme.text = "\(filme.pegarAnoFilme())"
        
        descricaoFIlme.text = filme.filmeDecodable.overview ?? ""
        
        posterFilme.image = filme.posterUIImage
        
        filme.verificarGenerosFilme(generosID: filme.filmeDecodable.genre_ids ?? [], completion: { (generos) in
            DispatchQueue.main.async {
                self.generoFilme.text = generos.joined(separator: ",")
            }
        })
    }
    
    @objc func favoritar(){
        
        guard let filme = filme else { return }
        
        if let id = filme.filmeDecodable.id {
            setupImagemBotao(id: id, imagem1: #imageLiteral(resourceName: "favorite_full_icon"), imagem2: #imageLiteral(resourceName: "favorite_gray_icon"))
            requestFavoritos.salvarFavorito(id: id)
        }
        
    }
    
    func setupImagemBotao(id: Int, imagem1: UIImage, imagem2: UIImage){
        var image: UIImage!
        if requestFavoritos.pegarFavoritoPorId(id: id) == nil {
            image = imagem1
        }else{
            image = imagem2
        }
        btFavorito.setBackgroundImage(image, for: .normal)
    }

}
