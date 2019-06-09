//
//  FavoriteViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Lottie

class FavoriteViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var viewImageEmpty: AnimationView!
    
    // MARK: CONSTANTS
    private let SEGUEDETAILMOVIE = "segueDetailMovie"
    private let SEGUEFILTER = "segueFilter"
    // MARK: VARIABLES
    private var presenter: FavoritePresenter!
    private lazy var viewData = FavoriteViewData()
    private lazy var viewDataFiltered = FavoriteViewData()
    public var isFilter = false
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
        self.showEmptyView()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !self.isFilter ? self.viewData.favoritesMovies.count : self.viewDataFiltered.favoritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        let viewData = !self.isFilter ? self.viewData.favoritesMovies[indexPath.row] : self.viewDataFiltered.favoritesMovies[indexPath.row]
        cell.prepareCell(viewData: viewData)
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
        self.viewDataFiltered.favoritesMovies.removeAll()
        if genre?.name == "Todos" && endDate == nil{
            self.isFilter = false
            self.tableView.reloadData()
            self.tableView.isHidden = false
            LottieHelper.hideAnimateion(lottieView: self.viewImageEmpty, in: self.viewEmpty)
            return
        }
        var search = RatingViewData()
        search.labelRating = "Resultado da busca: "
        if let dateFilter = endDate {
            search.movies += self.filterDate(date: dateFilter)
        }else if let genreFilter = genre {
            search.movies += self.filterGenre(genre: genreFilter)
        }
        self.viewDataFiltered.favoritesMovies.append(search)
        self.isFilter = true
        self.tableView.reloadData()
        if search.movies.count == 0 {
            self.showEmptySearch()
        } else {
            self.tableView.isHidden = false
            LottieHelper.hideAnimateion(lottieView: self.viewImageEmpty, in: self.viewEmpty)
        }
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
            controller.genreList = self.presenter.getGenresViewData().sorted(by: {$0.name < $1.name})
        }
    }
    
    private func filterDate(date: Date) -> [MovieElementViewData] {
        var viewDataTemp = [MovieElementViewData]()
        self.viewData.favoritesMovies.forEach { (viewDataRow) in
            let moviesFilter = viewDataRow.movies.filter({$0.detail.releaseDate.replacingOccurrences(of: "Lançamento: ", with: "").getDateFormatter() <= date})
            viewDataTemp += moviesFilter
        }
        return viewDataTemp
    }
    
    private func filterGenre(genre: GenreViewData) -> [MovieElementViewData] {
        var viewDataTemp = [MovieElementViewData]()
        self.viewData.favoritesMovies.forEach { (viewDataRow) in
            let moviesFilter = viewDataRow.movies.filter({$0.detail.genres.filter({$0.id == genre.id}).count > 0})
            viewDataTemp += moviesFilter
        }
        return viewDataTemp
    }
    
    private func showEmptyView() {
        LottieHelper.showAnimateion(for: .searchEmpty, lottieView: self.viewImageEmpty, in: self.viewEmpty)
        self.tableView.isHidden = true
    }
    
    private func showEmptySearch() {
        LottieHelper.showAnimateion(for: .searchEmpty, lottieView: self.viewImageEmpty, in: self.viewEmpty)
        self.tableView.isHidden = true
    }
}
