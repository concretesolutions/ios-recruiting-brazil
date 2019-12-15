//
//  FavoritesController.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class FavoritesController: UIViewController {
    let customView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.rowHeight = 150
        table.registerCell(cellType: MoviesTableViewCell.self)
        return table
    }()
    let coreDataManager = CoreDataManager()
    var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.customView.reloadData()
            }
        }
    }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        customView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movies = coreDataManager.fetchMovies() {
            self.movies = movies
        }
    }

    private func setNavigation() {
        self.title = "Favorites"
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.navigationController?.navigationBar.backgroundColor = .yellow
    }
}
