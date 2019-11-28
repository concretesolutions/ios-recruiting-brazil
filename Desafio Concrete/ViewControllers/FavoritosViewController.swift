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
    var filmesFavoritados = [Filme]()
    var filmesFiltrados = [Filme]()
    
    var anoSelecionado = 0
    var generoSelecionado = ""
    
    //***********************************
    //MARK: Ciclo de vida view controller
    //***********************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if anoSelecionado != 0 || generoSelecionado != "" { return }
        filmesFavoritados.removeAll()
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
        self.navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    //***********************************
    //MARK: Request Api
    //***********************************
    
    func pegarFavoritos(){
        let favoritos = FuncoesFilme().pegarListaFavoritos()
        let semaforo = DispatchSemaphore(value: favoritos.count)
        
        for idFavorito in favoritos {
            FuncoesFilme().pegarFilmesPorID(id: idFavorito) { (result, erro) in
                if let filme = result {
                    DispatchQueue.main.async {
                        self.filmesFiltrados.append(filme)
                        self.filmesFavoritados.append(filme)
                        self.tableView.reloadData()
                    }
                }
                semaforo.signal()
            }
            semaforo.wait()
        }
        
    }
    
    //***********************************
    //MARK: Filtro
    //***********************************

    @IBAction func escolherFiltro(_ sender: Any) {
        
        let opcoesFiltroViewController = self.storyboard?.instantiateViewController(withIdentifier: "OpcoesFiltroViewController") as! OpcoesFiltroViewController

        opcoesFiltroViewController.delegate = self
        
         self.navigationController?.pushViewController(opcoesFiltroViewController, animated: true)
        
    }
    
    func aplicarFiltro(){
        if anoSelecionado != 0 && generoSelecionado != ""{
            filmesFiltrados = filmesFiltrados.filter({ (filme) -> Bool in
                return (FuncoesFilme.pegarAnoFilme(filme: filme) == anoSelecionado) && (filme.generoFormatado.contains(generoSelecionado))
            })
        }else if anoSelecionado == 0 && generoSelecionado != "" {
            filmesFiltrados = filmesFiltrados.filter({ (filme) -> Bool in
                return (filme.generoFormatado.contains(generoSelecionado))
            })
        }else if anoSelecionado != 0 && generoSelecionado == "" {
            filmesFiltrados = filmesFiltrados.filter({ (filme) -> Bool in
                return (FuncoesFilme.pegarAnoFilme(filme: filme) == anoSelecionado)
            })
        }
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func removerFiltro(_ sender: Any) {
        anoSelecionado = 0
        generoSelecionado = ""
        filmesFiltrados = filmesFavoritados
        tableView.reloadData()
        removerFiltro.isHidden = true
    }
    
    
}

//***********************************
//MARK: Extensions
//***********************************

extension FavoritosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmesFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritoCell") as! FavoritosTableViewCell
        
        let filme = filmesFiltrados[indexPath.row]
        
        cell.nomeFilme.text = filme.filmeDecodable.title
        cell.poster.image = filme.posterUIImage
        cell.descricaoFilme.text = filme.filmeDecodable.overview
        cell.anoFilme.text = "\(FuncoesFilme.pegarAnoFilme(filme: filme))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
            let filme = filmesFiltrados[indexPath.row]
            FuncoesFilme().salvarFilmeFavorito(id: filme.filmeDecodable.id ?? 0 , filme: filme)
            self.filmesFiltrados.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
          }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Desfavoritar"
    }
    
}

extension FavoritosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //pesquisaAtual = searchController.searchBar.text ?? ""
        //pesquisarFilmes(searchBarText: pesquisaAtual)
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
        if let ano = date,
            let genero = genre{
            anoSelecionado = ano
            generoSelecionado = genero
            removerFiltro.isHidden = false
        }
        
        print(anoSelecionado)
        print(generoSelecionado)
        
        aplicarFiltro()
    }
}
