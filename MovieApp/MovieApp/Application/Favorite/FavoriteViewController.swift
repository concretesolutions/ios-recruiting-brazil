//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let controller: FavoriteController = FavoriteController()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-filter"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icons8-filter_filled"), for: .selected)
        return button
    }()
    
    
    private lazy var dataSource = FavoriteTableViewDataSource(tableView: self.tableView, delegate: self)
    
    override func loadView() {
        super.loadView()
        setupView()
        setupLayout()
        filterButton.addTarget(self, action: #selector(filterMovie), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.getMovies()
        tableView.reloadData()
        let genreDefaults = UserDefaults.standard.string(forKey: Strings.userDefaultsFilterDetailGenreKey)
        let year = UserDefaults.standard.string(forKey: Strings.userDefaultsFilterDetailYearKey)
        if genreDefaults != nil || year != nil {
            filterButton.isSelected = true
            filterIsActive()
        } else {
            filterButton.isSelected = false
        }
    }
    
    @objc func filterMovie() {
        let viewController = FilterViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func filterIsActive() {
        let genreDefaults = UserDefaults.standard.string(forKey: Strings.userDefaultsFilterDetailGenreKey)
        let year = UserDefaults.standard.string(forKey: Strings.userDefaultsFilterDetailYearKey)
        
        if filterButton.isSelected {
            if genreDefaults != nil && year != nil {
                controller.filterGenresAndYears(genreText: genreDefaults ?? "", yearText: year ?? "")
            } else if year != nil {
                controller.getYears(text: year ?? "")
            } else if genreDefaults != nil {
                controller.filterGenres(text: genreDefaults ?? "")
            }
            
        }
    }
    
    func setupView() {
        self.navigationController?.view.tintColor = .orange
        title = Strings.titleFavorites
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Strings.fontProject, size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.orange]
        controller.delegate = self
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension FavoriteViewController: FavoriteDataSourceDelegate {
    
    func editStyle(movie: Movie) {
        controller.delete(movie: movie) { (success) in
            if success {
                controller.getMovies()
                tableView.reloadData()
            }
        }
    }
    
    func didSelected(movie: Movie) {
        let viewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension FavoriteViewController: FavoriteControllerDelegate {
    func showMovies(movies: [Movie]) {
        dataSource.updateMovies(movies: movies)
    }
}
