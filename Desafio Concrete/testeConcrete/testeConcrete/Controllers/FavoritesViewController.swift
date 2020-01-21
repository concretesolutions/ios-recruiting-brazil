//
//  FavoritesViewController.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 15/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tabelafavoritos: UITableView!
    let dataSource = FavoriteDataSource()
}
extension FavoritesViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelafavoritos.dataSource = dataSource
        tabelafavoritos.delegate   = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataSource.loadFavoriteIds()
        tabelafavoritos.reloadData()
    }
}
extension FavoritesViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Desfavoritar") {  (contextualAction, view, boolValue) in
            //Code I want to do here
            Armazenamento.desfavoritar(id: Int(self.dataSource.listMovies[indexPath.row]["id"]!)!)
            self.dataSource.listMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        contextItem.backgroundColor = .red
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
}
