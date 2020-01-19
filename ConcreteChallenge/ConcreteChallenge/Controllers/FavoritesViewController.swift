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
    let notificationCenter = NotificationCenter.default
    
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
    
    init(movieCollection: MovieColletion) {
        self.movieCollection = movieCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = movieCollection.getFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.post(name: Notification.Name(Notifications.newFavoriteMovie), object: nil)
    }
    
    func addSubviews() {
        view.addSubview(emptyStateView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
