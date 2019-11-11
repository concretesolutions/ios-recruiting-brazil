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
        tableView.backgroundColor = UIColor(red: 0.238, green: 0.271, blue: 0.331, alpha: 1.0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.tintColor = .orange
        title = "Favorites"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.orange]
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.getMovies()
        tableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        self.tableView.showsVerticalScrollIndicator = false
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "favoriteCell")
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FavoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else { return UITableViewCell()}
        cell.setupCell(movie: controller.getMovie(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller.delete(movie: controller.getMovie(index: indexPath.row)) { (success) in
                if success {
                    controller.getMovies()
                    tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let viewController = DetailViewController()
        viewController.movieSave = controller.getMovie(index: indexPath.item)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
