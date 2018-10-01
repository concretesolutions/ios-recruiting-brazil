//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    enum Constants {
        static let nibName = "FavoritesViewController"
        static let title = "Favorites"
        static let cellNibName = "FavoritesTableViewCell"
    }

    @IBOutlet var favoritesTableView: UITableView!

    init() {
        super.init(nibName: Constants.nibName, bundle: nil)
        self.title = Constants.title
        tabBarItem.title = Constants.title
        tabBarItem.image = UIImage(named: "tabItemFavorites")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        favoritesTableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellNibName
        )
        favoritesTableView.estimatedRowHeight = 100
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellNibName,
            for: indexPath
        )
        guard let favoriteCell = cell as? FavoritesTableViewCell else {
            fatalError("Cell not configured")
        }
        // TODO: setup cell
        return favoriteCell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
