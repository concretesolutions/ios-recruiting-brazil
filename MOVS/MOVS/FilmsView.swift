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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Functions
    //MARK: - Public
    func setNavigationBar(){
        guard let navBarController = self.navigationController else {
            print("Error to get navBar in: \(FilmsView.self)")
            return
        }
        self.navigationController?.navigationBar.topItem?.title = "Filmes"
        DesignManager.configureNavigation(navigationController: navBarController)
    }
    
    func setSearchBar(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nome do filme"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}
