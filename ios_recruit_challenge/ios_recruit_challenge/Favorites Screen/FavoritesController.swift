//
//  FavoritesController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesView = FavoritesView()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        setupView()
    }
    
    func setupView(){
        favoritesView = FavoritesView(frame: self.view.frame)
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(favoritesView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FavoritesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
