//
//  FavoritesViewController.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    // MARK: - VARIABLES -
    private var presenter: FavoritesPresenter!
    private lazy var viewData = HomeViewData()
    private lazy var selectedFilters = [Genre]()
    private lazy var filteredMovies = [MovieViewData]()
    private var isFiltering = false
    
    // MARK: - IBACTIONS -
    @IBAction func presentFilterViewController(_ sender: Any) {
        self.showFilterViewController()
    }
}

// MARK: - LIFE CYCLE -
extension FavoritesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FavoritesPresenter(viewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !self.isFiltering { self.presenter.getMovies() }
    }
}

// MARK: - PRESENTER -
extension FavoritesViewController: FavoritesViewDelegate {
    func showMovies(viewData: FavoritesViewData) {
        self.viewData.movies = viewData.movies
        self.showFavoritesTableView()
    }
    
    func showEmptyList() {
        self.showEmptyView(messageLabel: "Você não possui nenhum filme favorito =(")
    }
}

// MARK: - FILTER ACTION DELEGATE -
extension FavoritesViewController: FilterActionDelegate {
    func applyFilter(selectedFilters: [Genre]) {
        guard !selectedFilters.isEmpty else { isFiltering = false; self.favoritesTableView.reloadData(); return }
        self.selectedFilters = selectedFilters
        self.isFiltering = true
        let selectedGenreIds = selectedFilters.compactMap({$0.genreId})
        self.filteredMovies = self.viewData.movies.filter({
            $0.genreIds.filter({ selectedGenreIds.contains($0) }).count > 0
        })
        guard self.filteredMovies.isEmpty else { self.showFavoritesTableView(); return }
        self.showEmptyView(messageLabel: "Você não possui nenhum filme favorito =(")
    }
}

// MARK: - TABLEVIEWDATASOURCE -
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !self.isFiltering else { return self.filteredMovies.count }
        return self.viewData.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNameID = Constants.Cells.movieTableViewCell
        tableView.register(UINib(nibName: cellNameID, bundle: nil), forCellReuseIdentifier: cellNameID)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNameID, for: indexPath) as! MovieTableViewCell
        let movieViewData = self.isFiltering ? self.filteredMovies[indexPath.row] : self.viewData.movies[indexPath.row]
        cell.setupCell(viewData: movieViewData)
        return cell
    }
}

// MARK: - TABLEVIEWDELEGATE -
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.Segues.showMovieDetail, sender: indexPath.row)
    }
}

// MARK: - PREPARE FOR SEGUE -
extension FavoritesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MovieDetailViewController,
            let anySender = sender, let index = anySender as? Int {
            viewController.viewData = self.isFiltering ? self.filteredMovies[index] : self.viewData.movies[index]
        }
    }
}

// MARK: - AUX METHODS -
extension FavoritesViewController {
    private func showFavoritesTableView() {
        self.changeAlpha(favoritesTableView: 1, emptyView: 0)
        self.favoritesTableView.reloadData()
    }
    
    private func showEmptyView(messageLabel: String) {
        self.emptyMessageLabel.text = messageLabel
        self.changeAlpha(favoritesTableView: 0, emptyView: 1)
    }
    
    private func changeAlpha(favoritesTableView: CGFloat, emptyView: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.favoritesTableView.alpha = favoritesTableView
            self?.emptyView.alpha = emptyView
        })
    }
    
    private func showFilterViewController() {
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? FilterViewController else { return }
        viewController.delegate = self
        if isFiltering { viewController.selectedFilters = self.selectedFilters }
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}
