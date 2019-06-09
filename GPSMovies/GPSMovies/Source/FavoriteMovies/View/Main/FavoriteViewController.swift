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
    private let SEGUEDETAILMOVIE = "segueDetailMovie"
    private let SEGUEFILTER = "segueFilter"
    // MARK: VARIABLES
    private var presenter: FavoritePresenter!
    private lazy var viewData:FavoriteViewData = FavoriteViewData()
    
    // MARK: IBACTIONS
    @IBAction func showFilter(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: self.SEGUEFILTER, sender: nil)
    }
    
}

//MARK: - LIFE CYCLE -
extension FavoriteViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FavoritePresenter(viewDelegate: self)
        self.registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.getFavoriteMovies()
    }
}

//MARK: - DELEGATE PRESENTER -
extension FavoriteViewController: FavoriteViewDelegate {
    
    func setViewData(viewData: FavoriteViewData) {
        self.viewData = viewData
        self.tableView.reloadData()
    }
    
    func showEmptyList() {
        self.viewData.favoritesMovies.removeAll()
        self.tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewData.favoritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        cell.prepareCell(viewData: self.viewData.favoritesMovies[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension FavoriteViewController: FavoriteTableViewCellDelegate {
    func showDetail(movieSelected: MovieElementViewData) {
        self.performSegue(withIdentifier: self.SEGUEDETAILMOVIE, sender: movieSelected)
    }
}

extension FavoriteViewController: FilterMoviesDelegate {
    func applyFilter(endDate: Date?, genre: GenreViewData?) {
        
    }
}

//MARK: - AUX METHODS -
extension FavoriteViewController {
    private func registerCell() {
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MovieDetailViewController, let viewData = sender as? MovieElementViewData {
            controller.viewData = viewData
        } else if let controller = segue.destination as? FilterMoviesViewController {
            controller.delegate = self
            controller.genreList = self.presenter.getGenresViewData()
        }
    }
}
