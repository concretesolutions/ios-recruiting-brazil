//
//  ViewController.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, Storyboarded {

    @IBOutlet weak var collectionViewMovies: UICollectionView!

    weak var coordinator: MainCoordinator?
    private var isLoading = false
    private let serviceManager = MoviesService()
    var viewModelData: [MovieViewModel]? = []
    var viewModelDataUnfiltred: [MovieViewModel]? = []
    var viewModelDataFiltered: [MovieViewModel]? = []
    var arrayMovies: [Result] = []

    let searchController = UISearchController(searchResultsController: nil)

    private var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchData(page: 1)

        collectionViewMovies.register(UINib(nibName: "MovieCell", bundle: .main),
                                         forCellWithReuseIdentifier: "movieCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionViewMovies.reloadData()
    }

    private func configureView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Procurar filmes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func fetchData(page: Int) {
        if Reachability.isConnectedToNetwork() {
            isLoading = true

            serviceManager.loadGenres { (response, _) in
                print(response ?? "")
                if let genres = response {
                    DBManager.sharedInstance.registerGenres(genres: genres)

                    self.serviceManager.loadMovies(page: "\(page)") { (response, _) in
                        if response != nil {
                            self.setViewModel(response: response)
                        } else {
                            print("error")
                        }
                        self.isLoading = false
                    }
                }
            }

        } else {
            showAlertInternet()
        }
    }

    private func showAlertInternet() {

    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        loadFilteredMovies(text: searchText)
        collectionViewMovies.reloadData()
    }

    func setViewModel(response: Movies?) {

        if let model = viewModelData {
            if model.isEmpty {
                if let movies = response?.results {
                    arrayMovies = movies
                    viewModelData = movies.map({ return MovieViewModel(item: $0)})
                }
            } else {
                if let movies = response?.results {
                    arrayMovies.append(contentsOf: movies)
                    viewModelData?.append(contentsOf: movies.map({
                        return MovieViewModel(item: $0) }))
                }
            }
        }

        viewModelDataUnfiltred = viewModelData

        collectionViewMovies.reloadData()
    }

    func loadFilteredMovies(text: String) {
        viewModelDataFiltered = (viewModelDataUnfiltred?.filter({(movie: MovieViewModel) -> Bool in
            return movie.title!.lowercased().contains(text.lowercased())
        }))!

        if text != "" {
            viewModelData = viewModelDataFiltered
        } else {
            viewModelData = viewModelDataUnfiltred
        }
    }

    @objc func bookmark(_ sender: UIButton) {

        if let idM = viewModelData?[sender.tag].idMovie {
            let result = arrayMovies.filter({ $0.idMovie == idM})

            if !result.isEmpty {
                if let res = result.first {
                    DBManager.sharedInstance.checkAndChangeState(movie: res)
                    let indexPath = IndexPath(row: sender.tag, section: 0)
                    collectionViewMovies.reloadItems(at: [indexPath])
                }
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewMovies.frame.width / 2 - 15,
                      height: collectionViewMovies.frame.width / 2 + 45)
    }
}

extension MoviesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let count = viewModelData?.count {
            return count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell",
                                                         for: indexPath) as? MovieCell {
            if let cellData = viewModelData?[indexPath.row] {
                cell.setCellData(cellData: cellData)
                cell.buttonStar.tag = indexPath.row
                cell.buttonStar.addTarget(self, action: #selector(bookmark(_:)), for: .touchUpInside)
            }

            return cell
        }

        return MovieCell()
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModelData?[indexPath.row] {
            let result = arrayMovies.filter({ $0.idMovie == viewModel.idMovie})
            if !result.isEmpty {
                if let res = result.first {
                    coordinator?.createDetails(to: viewModel, movie: res)
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isFiltering() {
            if let count = viewModelData?.count {
                if indexPath.row == count - 1 && isLoading == false {
                    if Reachability.isConnectedToNetwork() {
                        isLoading = true
                        page += 1
                        fetchData(page: page)
                    } else {
                        showAlertInternet()
                    }
                }
            }
        }
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(text)
        }
    }
}
