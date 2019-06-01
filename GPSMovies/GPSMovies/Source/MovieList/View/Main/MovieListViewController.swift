//
//  MovieListViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieListPresenter!
    private lazy var viewData:MovieListViewData = MovieListViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieListPresenter(viewDelegate: self)
        self.registerCell()
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieListViewController: MovieListViewDelegate {

}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        return cell
    }
    
    
}

//MARK: - AUX METHODS -
extension MovieListViewController {
    private func registerCell() {
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
}
