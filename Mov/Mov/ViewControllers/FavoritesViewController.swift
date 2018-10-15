//
//  FavoritesViewController.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class FavoritesViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - Actions
    @IBAction func ShowFilters(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showFilters", sender: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavs(_:)), name: Notification.Name(rawValue: "favoritesChanged"), object: nil)
    }
    
    override func setupInterface() {
        super.setupInterface()
        currentTitle = "Favorites"
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @objc private func reloadFavs(_ notification: Notification){
        self.tableView.reloadData()
    }

}

//MARK: - TableView DataSource, Delegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteController.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.setup(with: FavoriteController.shared.favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.showDetail(of: FavoriteController.shared.favorites[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("Removing favorite...")
        FavoriteController.shared.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
