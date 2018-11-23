//
//  FilmsView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsView: UIViewController {

    // MARK: - Properties
    // MARK: - Outlets
    @IBOutlet weak var outletFilmsCollectionView: UICollectionView!
    
    // MARK: - Public
    var presenter: FilmsPresenter!
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigation
        self.setNavigationBar()
        
        // Load collection
        self.presenter.viewDidLoad(withCollection: self.outletFilmsCollectionView, andSearchController: self.searchController)
        
        // Set Search on navigation
        self.setSearchBar()
        
    }

    
    //MARK: - Functions
    //MARK: - Public
    func setNavigationBar(){
        guard let navBar = self.navigationController?.navigationBar else {
            print("Error to get navBar in: \(FilmsView.self)")
            return
        }
        DesignManager.configureNavigation(navigationBar: navBar)
        navBar.topItem?.title = "Filmes"
    }
    
    func setSearchBar(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nome do filme"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}
