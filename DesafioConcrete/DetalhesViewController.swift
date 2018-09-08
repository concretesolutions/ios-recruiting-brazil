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
    var idFilme = 0 //Recebe ID via segue e busca no viewDidLoad
    var favorito = false//Recebe do grid se é um filme favorito
    
    //MARK: Ciclo da view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Inicializa referências
        referenciaRealtime = Database.database().reference()
        
        //Atualiza botão e label de favoritar
        atualizaBotaoFavorito()
        
        MovieMDB.movie(movieID: idFilme, language: "pt-BR", completion: { retornoAPI, filme in
            if let filme = filme{
                self.labelNome.text = filme.title
                
                //Busca a quantidade e valores correspondentes aos gêneros
                let generos = filme.genres.count
                var stringGeneros = ""
                for i in 0..<generos{
                    stringGeneros += filme.genres[i].name!
                    //Adiciona vírgulas até o último elemento
                    if (i+1)<generos{
                        stringGeneros += ", "
                    }//if i<generos
                }//for
                self.labelGenero.text = stringGeneros
                
                //Ano Lançamento
                let ano = filme.release_date?.prefix(4)
                self.labelAno.text = "Lançado em \(ano ?? "")"
                
                //Sinopse
                self.textViewDescricao.text = filme.overview
                
                //Definido padrão w780 para tamanho do backdrop
                let urlImagem = URL(string: "http://image.tmdb.org/t/p/w780\(filme.backdrop_path ?? "")")
                self.imagePoster.sd_setImage(with: urlImagem, placeholderImage: #imageLiteral(resourceName: "carregandoBackdrop"), options: .highPriority, completed: nil)
            }//if let filme = filme
        })// MovieMDB.movie
    }//viewWillAppear
    
    func atualizaBotaoFavorito(){
        if favorito{
            buttonFavoritar.setImage(#imageLiteral(resourceName: "favoritarSelecionado"), for: .normal)
            labelFavoritar.text = "Desfavoritar"
        }else{
            buttonFavoritar.setImage(#imageLiteral(resourceName: "favoritar"), for: .normal)
            labelFavoritar.text = "Favoritar"
        }//if favorito
    }
    
    //MARK: Action Buttons
    @IBAction func favoritar(_ sender: Any) {//Persiste no cadastro do usuário
        
        //Se já era favorito, deleta
        if favorito{
            let referenciaDelecao = Database.database().reference().child("\(idUsuarioAtual ?? "nulo")/favoritos").child("\(idFilme)")
            referenciaDelecao.removeValue()
            
            favorito = false
            atualizaBotaoFavorito()            
        }else{
            referenciaRealtime.child("\(idUsuarioAtual ?? "")/favoritos").child("\(idFilme)").setValue(idFilme)
            favorito = true
            atualizaBotaoFavorito()
        }//else !favorito
    }//func favoritar
    
    //Volta para a view de onde foi invocado. Tabela ou favoritos
    @IBAction func voltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }//func voltar
}//Fim da classe
