//
//  FavoritosViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 27/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

class FavoritosViewController: UIViewController {
    
    //***********************************
    //MARK: Variaveis
    //***********************************
    
    //OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removerFiltro: UIButton!
    @IBOutlet weak var viewErro: UIView!
    @IBOutlet weak var mensagemErro: UILabel!
    
    //var e let
    let variaveis = VariaveisFavoritos()
    var filmesFiltrados: [Filme] = [] {
        didSet{
            DispatchQueue.main.async {
                self.setupTableView()
            }
        }
    }

    
    //***********************************
    //MARK: Ciclo de vida view controller
    //***********************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        variaveis.requestFavoritos = RequestFavoritos(context: appDelegate.persistentContainer.viewContext)
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !variaveis.anoSelecionado.isZero() || !variaveis.generoSelecionado.isEmpty { return }
        variaveis.filmesFavoritados.removeAll()
        filmesFiltrados.removeAll()
        pegarFavoritos()
    }
    
    //***********************************
    //MARK: LAYOUT
    //***********************************

    func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    func setupTableView(){
        variaveis.dataSource = favoritosTableViewDataSource(elementos: filmesFiltrados, delegate: self, requestFavoritos: variaveis.requestFavoritos, tableView: tableView)
        variaveis.delegate = favoritosTableViewDelegate(elementos: filmesFiltrados)
        tableView.delegate = variaveis.delegate
        tableView.dataSource = variaveis.dataSource
        tableView.reloadData()
    }
    
    //***********************************
    //MARK: Request Api
    //***********************************
    
    func pegarFavoritos(){
        let favoritos = variaveis.requestFavoritos.pegarFavoritos()
        let semaforo = DispatchSemaphore(value: favoritos.count)
        
        if favoritos.count.isZero() {
            viewErro.isHidden = false
            mensagemErro.text = "Você ainda nāo tem filmes favoritados"
            return
        }
        
        tableView.isHidden = false
        viewErro.isHidden = true
        
        for idFavorito in favoritos {
            RequestAPI().pegarFilmesPorID(id: idFavorito) { result in
                DispatchQueue.main.async {
                switch result{
                    case .success(let filme):
                        self.filmesFiltrados.append(filme)
                        self.variaveis.filmesFavoritados.append(filme)
                    case .failure( _):
                        self.mostrarViewErro()
                    }
                }
                semaforo.signal()
            }
            semaforo.wait()
        }
        
    }
    
    //***********************************
    //MARK: Pesquisa Favoritos
    //***********************************
    
    func pesquisarFilmes(searchBarText: String){
        
        if searchBarText.isEmpty {
            filmesFiltrados = variaveis.filmesFavoritados
            return
        }
        
        filmesFiltrados = variaveis.filmesFavoritados.filter { (filme) -> Bool in
            let titulo = filme.filmeDecodable.title ?? ""
            return titulo.contains(searchBarText)
        }
        
    }
    
    //***********************************
    //MARK: Filtro
    //***********************************

    @IBAction func escolherFiltro(_ sender: Any) {
        
        let opcoesFiltroViewController = self.storyboard?.instantiateViewController(withIdentifier: "OpcoesFiltroViewController") as! OpcoesFiltroViewController

        opcoesFiltroViewController.variaveis.delegate = self
        
         self.navigationController?.pushViewController(opcoesFiltroViewController, animated: true)
        
    }
    
    func aplicarFiltro(){
        
        filmesFiltrados = Filtro().aplicarFiltro(filmesFiltrados: filmesFiltrados, anoSelecionado: variaveis.anoSelecionado, generoSelecionado: variaveis.generoSelecionado)
        
        mostrarViewErro()
    }
    
    @IBAction func removerFiltro(_ sender: Any) {
        variaveis.anoSelecionado = 0
        variaveis.generoSelecionado = ""
        filmesFiltrados = variaveis.filmesFavoritados
        mostrarViewErro()
        removerFiltro.isHidden = true
    }
    
    func mostrarViewErro(){
        if filmesFiltrados.count.isZero() {
            tableView.isHidden = true
            viewErro.isHidden = false
            mensagemErro.text = "Nāo há filmes favoritados com esses filtros"
        }else{
            tableView.isHidden = false
            viewErro.isHidden = true
        }
    }
    
}

//***********************************
//MARK: Extensions
//***********************************

extension FavoritosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        variaveis.pesquisaAtual = searchController.searchBar.text ?? ""
        pesquisarFilmes(searchBarText: variaveis.pesquisaAtual)
    }
}

extension FavoritosViewController {
    
    func esconderTeclado() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dispensarTeclado))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dispensarTeclado() {
        view.endEditing(true)
    }
}

extension FavoritosViewController: voltarFiltro {
    func voltarFiltro(date: Int?, genre: String?) {
        if let ano = date {
            variaveis.anoSelecionado = ano
            removerFiltro.isHidden = false
            aplicarFiltro()
        }
        
        if let genero = genre {
            variaveis.generoSelecionado = genero
            removerFiltro.isHidden = false
            aplicarFiltro()
        }
        
    }
}

extension FavoritosViewController: favoritoSelecionado {
    func didRemove(elementos: [Filme]) {
        self.filmesFiltrados = elementos
        self.variaveis.filmesFavoritados = elementos
        if elementos.count.isZero() {
            viewErro.isHidden = false
            mensagemErro.text = "Você ainda nāo tem filmes favoritados"
        }
    }

}


