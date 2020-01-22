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
    @IBOutlet weak var searchbar: UISearchBar!
    
}
extension FavoritesViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelafavoritos.dataSource = dataSource
        tabelafavoritos.delegate   = self
        searchbar.delegate         = self
        tabelafavoritos.keyboardDismissMode = .onDrag
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
extension FavoritesViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // hides the keyboard.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count==0){
            searchBar.resignFirstResponder()
        }
        dataSource.filtro = searchText;
        self.tabelafavoritos.reloadData()
    }
}
