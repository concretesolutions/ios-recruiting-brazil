//
//  FavoritesListViewController.swift
//  Movs
//
//  Created by vinicius emanuel on 16/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    @IBOutlet weak var removeFilterButton: UIButton!
    @IBOutlet weak var removeFilterButtonHight: NSLayoutConstraint!
    @IBOutlet weak var moviesTableView: UITableView!
    
    private let cellID = "movieCellID"
    private let segueID = "movieListToFilters"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
    }
    
    @IBAction func removeFilterPressed(_ sender: Any) {
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.segueID, sender: self)
    }
    
}

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! FavoMovieTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .destructive, title: "unfavorite") { (action, indexPath) in
            print(indexPath.row)
        }
        
        return [unfavorite]
    }
}
