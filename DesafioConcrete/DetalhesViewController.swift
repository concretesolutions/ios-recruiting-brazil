//
//  DetalhesViewController.swift
//  DesafioConcrete
//
//  Created by Matheus Henrique on 06/09/2018.
//  Copyright © 2018 Concrete.Matheus Henrique. All rights reserved.
//

import UIKit
import TMDBSwift//Interface com o TMDB
import Firebase//Persistência de dados e cadastro de usuário

class DetalhesViewController: UIViewController {
    
    //MARK: Declarações
    //Objetos de interface
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelAno: UILabel!
    @IBOutlet weak var labelGenero: UILabel!
    @IBOutlet weak var buttonFavoritar: UIButton!
    @IBOutlet weak var labelFavoritar: UILabel!    
    @IBOutlet weak var textViewDescricao: UITextView!
    //Variáveis
    var referenciaRealtime: DatabaseReference!
    let idUsuarioAtual = Auth.auth().currentUser?.uid
    var filme: Filme! //Recebe ID via segue e busca no viewDidLoad
    var favorito = false//Recebe do grid se é um filme favorito
    
    //MARK: Ciclo da view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Inicializa referências
        referenciaRealtime = Database.database().reference()
        
        //Atualiza botão e label de favoritar
        atualizaBotaoFavorito()
        
        labelNome.text = filme.nome
        labelAno.text = filme.ano
        
        MovieMDB.movie(movieID: filme.id, language: "pt-BR", completion: { retornoAPI, filmeEncontrado in
            if let filmeEncontrado = filmeEncontrado{
                //Busca a quantidade e valores correspondentes aos gêneros
                let generos = filmeEncontrado.genres.count
                var stringGeneros = ""
                for i in 0..<generos{
                    stringGeneros += filmeEncontrado.genres[i].name!
                    //Adiciona vírgulas até o último elemento
                    if (i+1)<generos{
                        stringGeneros += ", "
                    }//if i<generos
                }//for
                self.labelGenero.text = stringGeneros
                
                self.textViewDescricao.text = filmeEncontrado.overview
                
                //Definido padrão w780 para tamanho do backdrop
                let urlImagem = URL(string: "http://image.tmdb.org/t/p/w780\(filmeEncontrado.backdrop_path ?? "")")
                self.imagePoster.sd_setImage(with: urlImagem, placeholderImage: #imageLiteral(resourceName: "carregandoBackdrop"), options: .highPriority, completed: nil)
                
            }//if let filmeEncontrado = filmeEncontrado
        })// MovieMDB.movie
        
    }//viewWillAppear
    
    //MARK: Manipulação dos favoritos
    @IBAction func favoritar(_ sender: Any) {//Persiste no cadastro do usuário
        
        //Se já era favorito, deleta
        if favorito{
            let referenciaDelecao = Database.database().reference().child("\(idUsuarioAtual ?? "nulo")/favoritos").child("\(filme.id ?? 0)")
            referenciaDelecao.removeValue()
            
            favorito = false
            atualizaBotaoFavorito()            
        }else{
            referenciaRealtime.child("\(idUsuarioAtual ?? "")/favoritos").child("\(filme.id ?? 0)").setValue(filme.id)
            favorito = true
            atualizaBotaoFavorito()
        }//else !favorito
    }//func favoritar
    
    func atualizaBotaoFavorito(){
        if favorito{
            buttonFavoritar.setImage(#imageLiteral(resourceName: "favoritarSelecionado"), for: .normal)
            labelFavoritar.text = "Desfavoritar"
        }else{
            buttonFavoritar.setImage(#imageLiteral(resourceName: "favoritar"), for: .normal)
            labelFavoritar.text = "Favoritar"
        }//if favorito
    }//func atualizaBotaoFavorito()
    
    //Volta para a view de onde foi invocado. Tabela ou favoritos
    @IBAction func voltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }//func voltar
}//Fim da classe
