//
//  SecondViewController.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 06/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView! = UITableView()
    @IBOutlet weak var pesquisarFilmesFavotios: UISearchBar!
    @IBOutlet weak var activitity: UIActivityIndicatorView!
    
    var searchView = UIView()
    var errorView = UIView()
    
    var listaFilmes : [Filme] = []
    var listaComTodosFilmes : [Filme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.pesquisarFilmesFavotios.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Carrega os Filmes
        self.listaFilmes.removeAll()
        self.listaComTodosFilmes.removeAll()
        self.activitity.startAnimating()
        
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
                FilmesViewModel.shared.loadFilmes(page: pagina, completionHandler: { result  in
                    
                    //Carrega a lista de filmes favoritos
                    let listFavorites = FavoritoViewModel.shared.getListFavorites(listaFilme: result)
                    
                    //Pesquisa filmes favoritos caso exista um título na busca
                    self.listaFilmes = FilmesViewModel.shared.pesquisaFilmes(titulo: self.pesquisarFilmesFavotios.text!, lista: listFavorites)
                    
                    //Carrega lsta com todoso os filmes favoritados
                    self.listaComTodosFilmes = listFavorites
                    self.tableView.reloadData()
                    self.activitity.stopAnimating()
                })
            }
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaFilmes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filmeCell = tableView.dequeueReusableCell(withIdentifier: "FavoritoCell", for: indexPath) as! FavoritosTableViewCell
        filmeCell.confiqureCarCell(item: self.listaFilmes[indexPath.row])
        
        filmeCell.activitity.startAnimating()
        let imageURL = API_URL_IMAGES + listaFilmes[indexPath.row].image
        
        Alamofire.request(imageURL).responseImage { response in
            
            if case .success(let image) = response.result {
                //print("image downloaded: \(image)")
                filmeCell.activitity.stopAnimating()
                filmeCell.imagemFilme.image = image
            }
        }
        
        return filmeCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            FavoritoViewModel.shared.deleFavorito(favorite: self.listaFilmes[indexPath.row].id, completionHandler: { result  in
                if (result) {
                    //Remove View de Erro
                    self.errorView.removeFromSuperview()
                    
                    //Atualiza lista de Favoritos
                    self.listaFilmes.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.tableView.reloadData()

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
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaFilmes = FilmesViewModel.shared.pesquisaFilmes(titulo: searchText, lista: listaComTodosFilmes)
        
        if (listaFilmes.count == 0) {
            self.view.addSubview(self.searchView)
        } else {
            self.searchView.removeFromSuperview()
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func aplicarFiltros(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Filtros") as! FiltrosViewController
        //controller.filmeSelecionado = filme
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

