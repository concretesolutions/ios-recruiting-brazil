//
//  FavoriteViewController.swift
//  MovieAppTests
//
//  Created by Mac Pro on 30/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    let dataManager = DataManager()
    var array: [MovieFavorite] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataManager.loadData { (arrayMovie) in
            if arrayMovie!.count > 0{
                self.array = arrayMovie!
                self.tableView.reloadData()
            }else{
                print("Ruim")
            }
        }

    }

    func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")

    }
}

extension FavoriteViewController: UITableViewDelegate{
    
}

extension FavoriteViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell{
            cell.setCell(movie: array[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
