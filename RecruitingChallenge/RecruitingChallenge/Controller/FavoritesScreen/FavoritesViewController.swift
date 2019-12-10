//
//  FavoritesViewController.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/7/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class FavoritesViewController: UIViewController {
   
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var realm: Realm!
    var results: Results<RealmModel>?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        
        realm = try! Realm()
        results = realm.objects(RealmModel.self)
        
        let nibCellFavorite = UINib(nibName: "CellFavoritesScreen", bundle: nil)
        tableview.register(nibCellFavorite, forCellReuseIdentifier: "cellFavorite")
        
        tableview.dataSource = self
        tableview.delegate = self
 
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavorite", for: indexPath) as! CellFavoritesScreen
        
        let resultsWithIndex = results?[indexPath.item]
        let posterImage : UIImage = UIImage(data: resultsWithIndex!.posterImage!)!
        
        cell.uiImage.image = posterImage
        cell.uiTitleLbl.text = resultsWithIndex?.movieTitle
        cell.uiYearLbl.text = resultsWithIndex?.year
        cell.uiDescLbl.text = resultsWithIndex?.movieDesc
        

        return cell
    }
    
}
