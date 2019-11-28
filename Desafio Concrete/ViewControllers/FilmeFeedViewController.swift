//
//  FilmeFeedViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

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
    
    //Let e Vars
    var filmesPopulares = [Filme]()
    var filmesFiltrados = [Filme]()
    var paginaAtual = 1
    var pesquisaAtual = ""
    
    //***********************************
    //MARK: Ciclo de vida view controller
    //***********************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupLayoutCells()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        pegarFilmesPopulares()
        
        print(FuncoesFilme().pegarListaFavoritos())
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
    
    //***********************************
    //MARK: Pesquisa Filmes
    //***********************************
    
    func pesquisarFilmes(searchBarText: String){
        
        if searchBarText == "" {
            filmesFiltrados = filmesPopulares
            collectionView.reloadData()
            return
        }
        
        filmesFiltrados = filmesPopulares.filter { (filme) -> Bool in
            let titulo = filme.filmeDecodable.title ?? ""
            return titulo.contains(searchBarText)
        }
        collectionView.reloadData()
    }
    
    func pegarFilmesPopulares(){
        FuncoesFilme().pegarFilmesPopulares(pagina: 1) { (filmes, erro) in
            DispatchQueue.main.async {
                
                if let _ = erro {
                    self.viewErro(erro: .erroGenerico)
                }else{
                    if filmes.count > 0 {
                        self.viewErro.isHidden = true
                        self.filmesPopulares.removeAll()
                        self.filmesPopulares = filmes
                        self.filmesFiltrados = filmes
                        self.collectionView.reloadData()
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
        paginaAtual += 1
        
        FuncoesFilme().pegarFilmesPopulares(pagina: paginaAtual) { (filmes,erro) in
            
            DispatchQueue.main.async {
                
                if let _ = erro {
                    self.viewErro(erro: .erroGenerico)
                }else{
                    for filme in filmes {
                        self.filmesFiltrados.append(filme)
                    }
                    self.collectionView.reloadData()
                }
                
            }
            
        }
        
    }
    
    @objc func salvarFavorito(sender: UIButton){
        
        guard let indexFilme = (sender.layer.value(forKey: "index")) as? Int else { return }
    
        let filme = filmesFiltrados[indexFilme]
    
        if FuncoesFilme().verificarFavorito(id: filme.filmeDecodable.id ?? 0, filme: filme) == -1 {
            let image = #imageLiteral(resourceName: "favorite_full_icon")
            sender.setBackgroundImage(image, for: .normal)
        }else{
            let image = #imageLiteral(resourceName: "favorite_gray_icon")
            sender.setBackgroundImage(image, for: .normal)
        }
    
        FuncoesFilme().salvarFilmeFavorito(id: filme.filmeDecodable.id ?? 0, filme: filme)
    
    }
    
    //***********************************
    //MARK: Feedback erro
    //***********************************
    
    func viewErro(erro: Erro){
        
        viewErro.isHidden = false
        
        switch erro {
        case .naoAchou:
            imagemErro.image = #imageLiteral(resourceName: "search_icon")
            txtErro.text = "Sua busca por \(pesquisaAtual) nāo resultou em nenhum resultado."
        case .erroGenerico:
            imagemErro.image = #imageLiteral(resourceName: "error-image-icon-23")
            txtErro.text = "Um erro ocorreu. Por favor, tente novamente."
        }
            
    }
    

}


//***********************************
//MARK: Extensions
//***********************************

extension FilmeFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmesFiltrados.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedFilmeCell", for: indexPath) as! FilmeFeedCollectionViewCell
        
        let filme = filmesFiltrados[indexPath.row]
        
        cell.nomeFilme.text = filme.filmeDecodable.title
        cell.imagemFilme.image = filme.posterUIImage
        
        cell.btFavorito.layer.setValue(indexPath.row, forKey: "index")
        cell.btFavorito.addTarget(self, action: #selector(salvarFavorito), for: .touchUpInside)
        
        if FuncoesFilme().verificarFavorito(id: filme.filmeDecodable.id ?? 0, filme: filme) != -1 {
            let image = #imageLiteral(resourceName: "favorite_full_icon")
            cell.btFavorito.setBackgroundImage(image, for: .normal)
        }else{
            let image = #imageLiteral(resourceName: "favorite_gray_icon")
            cell.btFavorito.setBackgroundImage(image, for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //SE O ULTIMO FILME DA LISTA FOR MOSTRADO, CHAMAR A PROXIMA PAGINA
        if indexPath.row == filmesFiltrados.count - 1 && pesquisaAtual == "" {
            puxarProximaPagina()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = filmesFiltrados[indexPath.row]

        let filmeDetalheViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilmeDetalheViewController") as! FilmeDetalheViewController

        filmeDetalheViewController.filme = filme

        self.navigationController?.pushViewController(filmeDetalheViewController, animated: true)
    }
    
}

extension FilmeFeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        pesquisaAtual = searchController.searchBar.text ?? ""
        pesquisarFilmes(searchBarText: pesquisaAtual)
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

