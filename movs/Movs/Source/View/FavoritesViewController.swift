//
//  SecondViewController.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, MoviesViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoritesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        presenter = FavoritesPresenter(vc: self)
        presenter.getFavorites()
    }
    
    @IBAction func reload(_ sender: Any) {
        presenter.getFavorites()
    }
    
    func updateLayout() {
        tableView.reloadData()
    }

}

extension FavoritesViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.favorites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.setTitle(presenter.favorites[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
