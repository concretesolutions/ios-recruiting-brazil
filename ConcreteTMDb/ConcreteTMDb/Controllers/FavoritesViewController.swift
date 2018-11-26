//
//  FavoritesViewController.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 23/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var favoritesTableView: FavoritesTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoritesTableView.delegate = self.favoritesTableView
        self.favoritesTableView.dataSource = self.favoritesTableView

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTableView()
    }
    
    func setupTableView() {
        CoreDataManager.getFavoriteMovies { (movies) in
            self.favoritesTableView.favoritedMovies = movies
            self.favoritesTableView.reloadData()
        }
    }

}

