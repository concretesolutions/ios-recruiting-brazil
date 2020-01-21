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
}
