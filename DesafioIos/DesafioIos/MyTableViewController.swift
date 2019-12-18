//
//  MyTableViewController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 18/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class FavoritesMoviesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteMovieCellView.self, forCellReuseIdentifier: "myCell")

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight * 0.2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! FavoriteMovieCellView
        return cell
    }

}
