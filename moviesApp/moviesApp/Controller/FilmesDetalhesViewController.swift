//
//  FilmesDetalhesViewController.swift
//  moviesApp
//
//  Created by Victor Vieira Veiga on 06/12/19.
//  Copyright © 2019 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class FilmesDetalhesViewController: UIViewController {

    
    @IBOutlet weak var imgFilme: UIImageView!
    @IBOutlet weak var txtTitulo: UILabel!
    @IBOutlet weak var txtAno: UILabel!
    @IBOutlet weak var txtDescricao: UITextView!
    @IBOutlet weak var txtGenero: UILabel!
    
    
    @IBOutlet weak var btnFavorito: UIButton!
    
    var filmeSelecionado: Movie?
    var FundoImageURL = URL(string: "")
    var favorito : [NSManagedObject]=[]
    var genero = [GenreData]()
    
//    var conectBD: NSManagedObject?
//    var context: NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark - Cria conexão com CoreData
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        //let conectBD = NSEntityDescription.insertNewObject(forEntityName: "FilmesFavoritos", into: context!)
        let requisicaoFavorito = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
       
        do {
            self.favorito = try  context?.fetch(requisicaoFavorito) as! [NSManagedObject]
        } catch  {
            print ("Erro ao carregar Favorito")
        }
        
        
        //Mark - Carrega View
        if let backdropPath = filmeSelecionado?.backdrop_path {
            FundoImageURL = URL(string: Constantes.BaseImageURL+backdropPath)
        } else {
            FundoImageURL = Constantes.FundoPlaceholder
        }
        
        let imageData = try? Data(contentsOf: FundoImageURL!)
        if let imageData = imageData {
            imgFilme.image = UIImage(data: imageData)
        } else {
            imgFilme.image = UIImage(named: "placeholder")
        }
        txtTitulo.text = filmeSelecionado?.title
        txtAno.text = filmeSelecionado?.release_date
        txtDescricao.text = filmeSelecionado?.overview
        
        //Seta as imagens dos filmes favoritados
//        let fav = Favorito()
//        self.favorito = fav.carregaFavorito()
        //setFavorito()
        
        getGenero()
        
        for f in self.favorito {
            if let fav = f.value(forKey: "title") {
                if txtTitulo.text == fav as? String {
                    let image = UIImage(named: "favorite_full_icon.png")
                    btnFavorito.setImage(image, for: UIControl.State.normal)
                }
            }
            
        }
    }
    
    func favoritarFilme () {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let conectBD = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: context!)
            guard let titulo = txtTitulo.text else {return}
                
                conectBD.setValue(titulo, forKey: "title")
                
                do {
                    try context?.save()
                } catch  {
                    print("Erro ao Salvar Favorito")
                }
                
        
              btnFavorito.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
              
              let view = UIViewController() as? FavoritosTableViewController

                let fav = Favorito()
                view?.favoritos = fav.carregaFavorito()
                view?.favoritosTableView.reloadData()
        
               // performSegue(withIdentifier: "voltarSegue", sender: self)
              //navigationController?.popViewController(animated: true)
        
        
    }
    
    func desfavoritarFilme () {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
         guard let titulo = txtTitulo.text else {return}
        var i: Int = 0
        for fav in self.favorito {
            if fav.value(forKey: "title") as? String == titulo {
                context?.delete(fav)
                favorito.remove(at: i)
            }
            i = i+1
        }
        
        do {
            try context?.save()
        } catch let erro {
            print ("Erro ao remover item \(erro)")
        }
        
        btnFavorito.setImage(UIImage(named: "favorite_empty_icon.png"), for: .normal)
        
         //performSegue(withIdentifier: "voltarSegue", sender: self)
    }
    

    @IBAction func addFavoritos(_ sender: Any) {
    
        
        if btnFavorito.currentImage == UIImage.init(named: "favorite_full_icon.png") {
            desfavoritarFilme ()
        }else {
            favoritarFilme()
        }
        
        
        
////        let appDelegate = UIApplication.shared.delegate as? AppDelegate
////        guard let context = appDelegate?.persistentContainer.viewContext else { return  }
////        let favorito = NSEntityDescription.insertNewObject(forEntityName: "Favoritos", into: context)
//
//        guard let titulo = txtTitulo.text else {return}
//
//        self.conectBD?.setValue(titulo, forKey: "title")
//
//        do {
//            try self.context?.save()
//        } catch  {
//            print("Erro ao Salvar Favorito")
//        }
//
////        let view = UIViewController() as? FilmesViewController
////        view?.collectionFilmes.reloadData()
//        navigationController?.popViewController(animated: true)
        
        
    }
    
    func setFavorito() {
            
        for f in self.favorito {
                guard let fav = f.value(forKey: "title") else {return}
                if txtTitulo.text == fav as? String {
                    let image = UIImage(named: "favorite_full_icon.png")
                    btnFavorito.setImage(image, for: UIControl.State.normal)
                }
            }
    }
    
    
    private func getGenero() {
        var names = [String]()
        let url = URL(string: Constantes.BaseGeneroURL)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            guard let jsonData = data else {
                print("Error, no data")
                return
            }
            do {
                let json = try JSONDecoder().decode(Genre.self, from: jsonData)
                self.genero = json.genres
                for genre in self.genero {
                    for genreId in self.filmeSelecionado!.genre_ids {
                        if genreId == genre.id {
                            names.append(genre.name!)
                        }
                    }
                }
                DispatchQueue.main.async {
                    if names.indices.contains(1) {
                        self.txtGenero.text = "Genres: \(names[0]), \(names[1])"
                    } else {
                        self.txtGenero.text = "Genres: \(names[0])"
                    }
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
    
}
