//
//  FirstViewController.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 06/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITabBarControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var colecaoFilme: UICollectionView!
    @IBOutlet weak var pesquisarFilmes: UISearchBar!
    
    var searchView = UIView()
    var errorView = UIView()
    
    var listaFilmes : [Filme] = []
    var listaComTodosFilmes : [Filme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colecaoFilme.dataSource = self
        self.colecaoFilme.delegate = self
        self.pesquisarFilmes.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Carrega os Filmes
        self.listaFilmes.removeAll()
        self.listaComTodosFilmes.removeAll()

        //Cria view de retorno da pesquisa.
        self.searchView = SearchView.shared.loadView(view: self.view)
        
        //Recupera a quatidade e paginas para o Loop
        FilmesViewModel.shared.getTotalPages(completionHandler: { totalPages in
            
            //Reduzindo número de paginas para o desafio
            var total = totalPages
            if (total > 10) {
                total = 10
            }
            
            for pagina in 1 ..< total-1 {
                
                //Para cada página carrega a lista de filmes
                FilmesViewModel.shared.loadFilmes(page: pagina, completionHandler: { result in
                    
                    if (result.count > 0) {
                        
                        //Remove View de Erro
                        self.errorView.removeFromSuperview()
                        
                        self.listaFilmes = result
                        self.listaComTodosFilmes = result
                        
                        //Pesquisa filmes caso exista um título na busca
                        self.listaFilmes = FilmesViewModel.shared.pesquisaFilmes(titulo: self.pesquisarFilmes.text!, lista: self.listaComTodosFilmes)
                        
                        self.colecaoFilme.reloadData()
                    }
                })
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listaFilmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaFilme = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaFilme", for: indexPath) as! FilmeCollectionViewCell
        
        let filmeAtual = listaFilmes[indexPath.item]
        celulaFilme.configuraCelula(filme: filmeAtual)
        celulaFilme.activitity.startAnimating()
        
       celulaFilme.butonFavorito.setImage(UIImage(named: FavoritoViewModel.shared.changeIcoFavorite(favorite: listaFilmes[indexPath.item].id)), for: .normal)
        
        let imageURL = API_URL_IMAGES + listaFilmes[indexPath.row].image
        
        Alamofire.request(imageURL).responseImage { response in
            
            if case .success(let image) = response.result {
                //print("image downloaded: \(image)")
                celulaFilme.activitity.stopAnimating()
                celulaFilme.imagemFilme.image = image
            }
        }
        
        return celulaFilme
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let larguraCelula = collectionView.bounds.width
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: larguraCelula/2-20, height: 160) : CGSize(width: larguraCelula/3-20, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = listaFilmes[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FilmeDetalhes") as! FilmeDetalhesViewController
        controller.filmeSelecionado = filme
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaFilmes = FilmesViewModel.shared.pesquisaFilmes(titulo: searchText, lista: listaComTodosFilmes)
        
        if (listaFilmes.count == 0) {
            self.view.addSubview(self.searchView)
        } else {
            self.searchView.removeFromSuperview()
        }
        
        self.colecaoFilme.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

