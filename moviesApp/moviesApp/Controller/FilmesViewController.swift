//
//  FilmesViewController.swift
//  moviesApp
//
//  Created by Victor Vieira Veiga on 04/12/19.
//  Copyright © 2019 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class FilmesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var isError:Bool = false
    var favorito : [NSManagedObject]=[]
    
    @IBOutlet weak var collectionFilmes: UICollectionView!
    
     var filmes = [Movie] () {
        didSet {
            DispatchQueue.main.async {
                self.collectionFilmes.reloadData()
            }
        }
    }
    
  
    var filmesPassagem: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionFilmes.delegate = self
        collectionFilmes.dataSource = self

        getMovies()
        carregaFavorito ()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        getMovies()
//        carregaFavorito ()
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FilmesCollectionViewCell {
            
                 let filme = filmes[indexPath.item]
                 let filmePosterPath = filme.poster_path
                 let imageUrl = URL(string:Constantes.BaseImageURL+filmePosterPath)!
                 let imageRequest = URLRequest(url: imageUrl)
                 let imageCache = URLCache.shared
            
            if let data = imageCache.cachedResponse(for: imageRequest)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.labelNomeFilme.text = filme.title
                    cell.imgFoto.image = image
                    //cellSpinner.stopAnimating()
                }
            } else {
                URLSession.shared.dataTask(with: imageRequest, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        imageCache.storeCachedResponse(cachedData, for: imageRequest)
                        
                        DispatchQueue.main.async {
                            cell.imgFoto.image = image
                            cell.labelNomeFilme.text = filme.title
                        }
                    }
                }).resume()
            }
            
            for fav in self.favorito {
                if filme.title == fav.value(forKey: "title") as? String  {
                    let image = UIImage(named: "favorite_full_icon.png")
                    cell.imgFavorito.image = image
                }
            }
            
            
            return cell
            
        }
        
        return  UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filmesPassagem = filmes[indexPath.item]
        performSegue(withIdentifier: "filmeDetalheSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detalhe = segue.destination as? FilmesDetalhesViewController {
            detalhe.filmeSelecionado = filmesPassagem
        }
    }

    func getMovies () {
                ApiFilmes.loadMovies(onComplete: { (movies) in
                    self.filmes = movies.results
                }) { (error) in
                    print(error)

                }
    }
    
    func carregaFavorito () {
        //Mark - Cria conexão com CoreData
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let context = appDelegate?.persistentContainer.viewContext
         let requisicaoFavorito = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        
         do {
             self.favorito = try  context?.fetch(requisicaoFavorito) as! [NSManagedObject]
         } catch  {
             print ("Erro ao carregar Favorito")
         }
        
        collectionFilmes.reloadData()
    }
    
}
