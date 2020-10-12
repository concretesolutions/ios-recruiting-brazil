//
//  FavoritesController.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit
import RealmSwift

class FavoritesController: UITableViewController {
    
    private let realm = try! Realm()
    private var itemsFavorites = [FavoriteEntity]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTableView()
    }
    
    private func setupTableView() {
        itemsFavorites = realm.objects(FavoriteEntity.self).map({ $0 })
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseListFavorites")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        refresh()
    }
    
    private func refresh() {
        itemsFavorites = realm.objects(FavoriteEntity.self).map({ $0 })
        tableView.reloadData()
    }
}

extension FavoritesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsFavorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseListFavorites", for: indexPath)
        
        let item = itemsFavorites[indexPath.row]
        
        cell.textLabel?.text = item.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
