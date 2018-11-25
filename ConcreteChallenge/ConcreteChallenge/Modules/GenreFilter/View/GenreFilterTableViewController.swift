//
//  GenreFilterTableViewController.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 15/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol GenreFilterTableViewActions {
    func didSelectGenre(genre: Genre)
    func didDeselectGenre(genre: Genre)
}

class GenreFilterTableViewController: UITableViewController, GenreFilterView, GenreFilterTableViewActions {
    
    
    // MARK: - Outlets
    @IBOutlet var genreFilterTableView: GenreFilterTableView!
    
    // MARK: - Actions

    // MARK: - Properties
    var presenter: GenreFilterPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
    }

    // MARK: - GenreFilterView Functions
    func showGenres(genres: [Genre]) {
        
    }
    
    // MARK: - Functions
    func setupNavigationBar() {
        // Title
        self.navigationItem.title = "Dates"
        
        // Right Navigation Item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    func setupTableView() {
        self.genreFilterTableView.delegate = self.genreFilterTableView
        self.genreFilterTableView.dataSource = self.genreFilterTableView
        self.genreFilterTableView.tableViewActions = self
    }
    
    @objc func saveButtonTapped() {
        self.presenter.didTapSaveButton()
    }
    
    // MARK: - GenreFilterTableViewActions functions
    func didSelectGenre(genre: Genre) {
        self.presenter.didSelectGenre(genre: genre)
    }
    
    func didDeselectGenre(genre: Genre) {
        self.presenter.didDeselectGenre(genre: genre)
    }
}

