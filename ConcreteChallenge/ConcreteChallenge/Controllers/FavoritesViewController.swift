//
//  FavoritesViewController.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let movieCollection: MovieColletion
    let genreCollection: GenreCollection
    let notificationCenter = NotificationCenter.default
    
    var isFiltering = false
    var chosenFilter: (date: String, genre: Int) = ("", 0)
    
    var favorites = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavMovieTableViewCell.self, forCellReuseIdentifier: Cells.favorite)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    lazy var emptyStateView: EmptyStateView = {
        let emptyStateView = EmptyStateView(state: .emptyFavorites)
        
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        
        return emptyStateView
    }()
    
    lazy var removeFilterButton: UIButton = {
        let removeFilterButton = UIButton(type: .system)
        
        removeFilterButton.translatesAutoresizingMaskIntoConstraints = false
        removeFilterButton.backgroundColor = .black
        removeFilterButton.setTitleColor(.white, for: .normal)
        removeFilterButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .regular)
        removeFilterButton.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        
        return removeFilterButton
    }()
    
    init(movieCollection: MovieColletion, genreCollection: GenreCollection) {
        self.movieCollection = movieCollection
        self.genreCollection = genreCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        rightBarButtonItem.tintColor = .black
        self.navigationItem.rightBarButtonItem  = rightBarButtonItem
        navigationController?.navigationBar.isTranslucent = false
        
        addSubviews()
        setupConstraints()
    }
    
    @objc func filter() {
        let filterViewController = FilterViewController(genreCollection: genreCollection)
        let navigationController = UINavigationController(rootViewController: filterViewController)
        
        filterViewController.title = "Filter"
        navigationController.navigationBar.tintColor = .black
        filterViewController.delegate = self
        
        present(navigationController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFiltering {
            favorites = movieCollection.getFavorites(for: chosenFilter)
        } else {
            favorites = movieCollection.getFavorites()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.post(name: Notification.Name(Notifications.newFavoriteMovie), object: nil)
    }
    
    func addSubviews() {
        view.addSubview(emptyStateView)
        view.addSubview(tableView)
        view.addSubview(removeFilterButton)
    }
    
    var buttonHeight: NSLayoutConstraint?
    
    func setupConstraints() {
        emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        removeFilterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        removeFilterButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        removeFilterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonHeight = removeFilterButton.heightAnchor.constraint(equalToConstant: 0)
        
        buttonHeight?.isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: removeFilterButton.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc
    func removeFilter() {
        isFiltering = false
        favorites = movieCollection.getFavorites()
        buttonHeight?.constant = 0
        removeFilterButton.setTitle(nil, for: .normal)
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.count == 0 {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.favorite, for: indexPath) as? FavMovieTableViewCell else { return UITableViewCell()}
        
        let movie = favorites[indexPath.row]
        
        cell.setup(for: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            tableView.beginUpdates()
            self.movieCollection.updateState(for: self.favorites[indexPath.row])
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            complete(true)
        }
        
        deleteAction.image = UIImage(named: Images.heartHollow)
        deleteAction.backgroundColor = .black
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.25
    }
}

extension FavoritesViewController: FilterViewControllerDelegate {
    func applyFilter(for date: String, genreID: Int) {
        chosenFilter = (date, genreID)
        isFiltering = true
        buttonHeight?.constant = 48
        removeFilterButton.setTitle("Remove Filter", for: .normal)
        
        favorites = movieCollection.getFavorites(for: chosenFilter)
    }
}
