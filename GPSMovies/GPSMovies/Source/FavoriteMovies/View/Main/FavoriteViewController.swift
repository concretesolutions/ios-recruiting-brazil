//
//  FavoriteViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: FavoritePresenter!
    private lazy var viewData:FavoriteViewData = FavoriteViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension FavoriteViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FavoritePresenter(viewDelegate: self)
        self.registerCell()
    }
}

//MARK: - DELEGATE PRESENTER -
extension FavoriteViewController: FavoriteViewDelegate {

}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell")!
        return cell
    }
    
    
}

//MARK: - AUX METHODS -
extension FavoriteViewController {
    private func registerCell() {
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
}
