//
//  SecondViewController.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        presenter = MoviesPresenter(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getFavorites()
    }
    
    func updateLayout() {
        tableView.reloadData()
    }
    
    func showErrorLayout() {
        
    }

}

extension FavoritesViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.favorites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: presenter.favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.unfavorite(presenter.favorites[indexPath.row])
        }
    }
    
}
