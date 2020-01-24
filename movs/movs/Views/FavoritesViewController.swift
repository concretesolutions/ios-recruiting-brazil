//
//  FavoritesViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    internal var movie = [Movie]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .filterIcon, style: .plain, target: self, action: #selector(self.filterAction))
        
        self.setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.movie = DataManager().getMovies()
        }
    }
    
    @objc private func filterAction() {
        let view = FilterViewController()
        let nav = NavigationController(rootViewController: view)
        self.present(nav, animated: true, completion: nil)
    }

}

extension FavoritesViewController {
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: UITableViewCell.self)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
        
        let movie = self.movie[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.releaseDate
        cell.detailTextLabel?.textColor = .primary
        return cell
    }
    
}
