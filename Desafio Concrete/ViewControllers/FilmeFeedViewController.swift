//
//  FilmeFeedViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit
import CoreData

enum Erro {
    case naoAchou
    case erroGenerico
}

class FilmeFeedViewController: UIViewController {
    
    //***********************************
    //MARK: Variaveis
    //***********************************
    
    //IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //View Erro
    @IBOutlet weak var txtErro: UILabel!
    @IBOutlet weak var imagemErro: UIImageView!
    @IBOutlet weak var viewErro: UIView!
    
    var variaveis: VariaveisFeed!
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
        variaveis = VariaveisFeed(collectionView: self.collectionView)
        setupSearchBar()
        setupLayoutCells()
        pegarContexto()
        variaveis.requestFavoritos = RequestFavoritos(context: variaveis.context)
        pegarFilmesPopulares()
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
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
    
    func setupLayoutCells(){
        
        let screen = UIScreen.main.bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 10, right: 8)
        layout.itemSize = CGSize(width: screen.width/2.15, height: screen.height/2.65)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
    }
    
    func setupTableView(){
        variaveis.delegate = feedCollectionViewDelegate(filmes: filmesFiltrados, delegate: self)
        variaveis.dataSource = feedCollectionViewDataSource(filmes: filmesFiltrados, context: variaveis.context, requestFavoritos: variaveis.requestFavoritos)
        
        collectionView.delegate = variaveis.delegate
        collectionView.dataSource = variaveis.dataSource
        collectionView.reloadData()
    }
    
    //***********************************
    //MARK: Context
    //***********************************
    
    func pegarContexto(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        variaveis.context = appDelegate.persistentContainer.viewContext
    }
    
    //***********************************
    //MARK: Pesquisa Filmes
    //***********************************
    
    func pesquisarFilmes(searchBarText: String){
        
        if searchBarText.isEmpty {
            filmesFiltrados = variaveis.filmesPopulares
            return
        }
        
        filmesFiltrados = variaveis.filmesPopulares.filter { (filme) -> Bool in
            let titulo = filme.filmeDecodable.title ?? ""
            return titulo.contains(searchBarText)
        }
    }
    
    func pegarFilmesPopulares(){
        RequestAPI().pegarFilmesPopulares(pagina: 1) { (filmes, erro) in
            DispatchQueue.main.async {
                
                if let _ = erro {
                    self.viewErro(erro: .erroGenerico)
                }else{
                    if filmes.count > 0 {
                        self.viewErro.isHidden = true
                        self.variaveis.filmesPopulares.removeAll()
                        self.variaveis.filmesPopulares = filmes
                        self.filmesFiltrados = filmes
                    }else{
                        self.viewErro(erro: .naoAchou)
                    }
                }
                
            }
        }
    }
    
    //***********************************
    //MARK: Paginaçāo
    //***********************************
    
    func puxarProximaPagina(){
        
        //IR PARA PROXIMA PAGINA
        variaveis.paginaAtual += 1
        
        RequestAPI().pegarFilmesPopulares(pagina: variaveis.paginaAtual) { (filmes,erro) in
            
            DispatchQueue.main.async {
                
                if let _ = erro {
                    self.viewErro(erro: .erroGenerico)
                }else{
                    for filme in filmes {
                        self.filmesFiltrados.append(filme)
                        self.variaveis.filmesPopulares.append(filme)
                    }
                }
                
            }
            
        }
        
    }
    
    //***********************************
    //MARK: Feedback erro
    //***********************************
    
    func viewErro(erro: Erro){
        
        viewErro.isHidden = false
        
        switch erro {
        case .naoAchou:
            imagemErro.image = #imageLiteral(resourceName: "search_icon")
            txtErro.text = "Sua busca por \(variaveis.pesquisaAtual) nāo resultou em nenhum resultado."
        case .erroGenerico:
            imagemErro.image = #imageLiteral(resourceName: "error-image-icon-23")
            txtErro.text = "Um erro ocorreu. Por favor, tente novamente."
        }
        
    }

}

//***********************************
//MARK: Extensions
//***********************************

extension FilmeFeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        variaveis.pesquisaAtual = searchController.searchBar.text ?? ""
        pesquisarFilmes(searchBarText: variaveis.pesquisaAtual)
    }
}

extension FilmeFeedViewController {
    func esconderTeclado() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dispensarTeclado))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dispensarTeclado() {
        view.endEditing(true)
    }
}

extension FilmeFeedViewController: feedSelecionado {
    func didSelect(filme: Filme) {

        let filmeDetalheViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilmeDetalheViewController") as! FilmeDetalheViewController

        filmeDetalheViewController.filme = filme

        self.navigationController?.pushViewController(filmeDetalheViewController, animated: true)
    }
    
    func puxarProximaPagina(index: IndexPath) {
        //SE O ULTIMO FILME DA LISTA FOR MOSTRADO, CHAMAR A PROXIMA PAGINA
        if index.row == filmesFiltrados.count - 1 && variaveis.pesquisaAtual.isEmpty {
             puxarProximaPagina()
        }
    }
}

