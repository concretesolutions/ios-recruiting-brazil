//
//  FilmeFeedViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

class FilmeFeedViewController: UIViewController {
    
    //***********************************
    //MARK: Variaveis
    //***********************************
    
    //IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Let e Vars
    
    var filmesPesquisados = [Filme]()
    
    //***********************************
    //MARK: Ciclo de vida view controller
    //***********************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupLayoutCells()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        FuncoesFilme().pegarFilmesPorNome(nome: "Homem", pagina: 0, filtro: "") { (result) in
            DispatchQueue.main.async {
                print(result.count)
                self.filmesPesquisados = result
                self.collectionView.reloadData()
            }
        }
    
    }
    
    //***********************************
    //MARK: LAYOUT
    //***********************************
    
    func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
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

}


//***********************************
//MARK: Extensions
//***********************************

extension FilmeFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmesPesquisados.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedFilmeCell", for: indexPath) as! FilmeFeedCollectionViewCell
        
        let filme = filmesPesquisados[indexPath.row]
        cell.nomeFilme.text = filme.filmeDecodable.title
        
        return cell
    }
}

extension FilmeFeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}

