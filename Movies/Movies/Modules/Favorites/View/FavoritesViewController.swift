//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favorites: UITableView!
    
    // MARK: - Properties
    
    var presenter: FavoritesPresentation!
    private var removeFilterButton: UIButton!
    
    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - FavoritesView protocol functions
    
    func present(movies: [Movie]) {
        
    }
    
    func showRemoveFilterButton() {
        
    }
    
    func hideRemoveFilterButton() {
        
    }
    
    // MARK: - Actions
    
    @objc func didTapFilterButton() {
        
    }
    
    @objc func didTapHideFilterButton() {
        
    }
    

}
