//
//  PopularMoviesTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

struct CustomSegueSender {
    var result: Result?
    var behavior: DescriptionBehavior
}

class PopularViewController: UITableViewController {
    /// Behavior View IBOutlets
    @IBOutlet var emptySearchView: UIView!
    @IBOutlet var genericErrorView: UIView!
    @IBOutlet var loadingView: UIView!
    
    /// Class Attributes
    var popularMovie: PopularMovie?
    var favorite = Favorite()
    var behavior: Behavior = .LoadingView {
        didSet {
            self.tableView.reloadData()
        }
    }
    let heightForPopularRow = CGFloat(200.0)
    let popularMovieCellIdentifier = "popularCell"
    let popularToDescriptionSegue = "PopularToDescription"
    
    /// Infinity Scroll Attributes
    var fetchingMore = false
    var page = 1
    
    /// Search Attributes
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPopular = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
        searchSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        switch behavior {
        case .GenericError:
            dataSetup()
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueData = sender as? CustomSegueSender else { return }
        if let vc = segue.destination as? DescriptionViewController {
            vc.data = segueData.result
            vc.behavior = segueData.behavior
        }
    }
    
}

// MARK: TableView data source
extension PopularViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if behavior == .Success && popularMovie != nil {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isFiltering() {
        case true:
            return filteredPopular.count
        case false:
            if let numberOfRows = popularMovie?.results?.count {
                return numberOfRows
            }
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: popularMovieCellIdentifier,
                                                 for: indexPath) as? PopularTableViewCell
        let data: Result
        switch isFiltering() {
        case true:
            data = filteredPopular[indexPath.row]
            isFavorite(result: data, completionHandler: { (status) in
                cell?.setData(data: data, isFavorite: status)
            })
        case false:
            if let data = popularMovie?.results?[indexPath.row] {
                isFavorite(result: data, completionHandler: { (status) in
                    cell?.setData(data: data, popularRanking: (indexPath.row + 1), isFavorite: status)
                })
            }
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data: Result
        switch isFiltering() {
        case true:
            data = filteredPopular[indexPath.row]
            isFavorite(result: data, completionHandler: { (favorite) in
                var customSender: CustomSegueSender?
                if favorite {
                    customSender = CustomSegueSender(result: data, behavior: .Favorite)
                } else {
                    customSender = CustomSegueSender(result: data, behavior: .Normal)
                }
                self.performSegue(withIdentifier: self.popularToDescriptionSegue, sender: customSender)
            })
        case false:
            if let data = popularMovie?.results?[indexPath.row] {
                isFavorite(result: data, completionHandler: { (favorite) in
                    var customSender: CustomSegueSender?
                    if favorite {
                        customSender = CustomSegueSender(result: data, behavior: .Favorite)
                    } else {
                        customSender = CustomSegueSender(result: data, behavior: .Normal)
                    }
                    self.performSegue(withIdentifier: self.popularToDescriptionSegue, sender: customSender)
                })
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForPopularRow
    }
}

// MARK: Data setup
extension PopularViewController {
    func dataSetup() {
        tableView.tableFooterView = UIView()
        setBehavior(newBehavior: .LoadingView)
        fetchPopularMovieData(page: page) { (popular) -> Void in
            if let data = popular {
                self.popularMovie = data
                self.setBehavior(newBehavior: .Success)
            }
        }
    }
    
    private func searchSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar filmes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setBehavior(newBehavior: Behavior) {
        behavior = newBehavior
        switch behavior {
        case .Success:
            tableView.backgroundView = UIView()
        case .EmptySearch:
            tableView.backgroundView = emptySearchView
        case .LoadingView:
            tableView.backgroundView = loadingView
        case .GenericError:
            tableView.backgroundView = genericErrorView
        }
    }
}

// MARK: Service call
extension PopularViewController {
    private func fetchPopularMovieData(page: Int, completionHandler: @escaping (PopularMovie?) -> Void) {
        PopularMovieServices.getPopularMovie(page: page) { (data, _) in
            if data != nil {
                self.setBehavior(newBehavior: .Success)
                completionHandler(data)
            } else {
                self.setBehavior(newBehavior: .GenericError)
                completionHandler(nil)
            }
        }
    }
    
    private func isFavorite(result: Result, completionHandler: @escaping (Bool) -> Void) {
        FavoriteServices.getAllFavorite { (_, data) in
            guard let favorite = data?.filter({ (fav) -> Bool in
                return Int(fav.id) == result.id
            }).isEmpty else {return}
            completionHandler(!favorite)
        }
    }
}

// MARK: Infinity Scroll Functions
extension PopularViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && contentHeight != 0.0 {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        self.page += 1
        fetchPopularMovieData(page: page) { (popular) -> Void in
            if let data = popular {
                if let oldResults = self.popularMovie?.results,
                    let newResults = data.results {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        /// Fetching more results
                        self.popularMovie?.results? = oldResults + newResults
                        self.fetchingMore = false
                    })
                }
            }
        }
        
    }
}

// MARK: Search Functions
extension PopularViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if behavior == .Success || behavior == .EmptySearch {
            guard let popular = popularMovie?.results else {return}
            filteredPopular = popular.filter({( movie: Result) -> Bool in
                guard let title = movie.title else {return false}
                return title.lowercased().contains(searchText.lowercased())
            })
            /// Call Empty Search behavior if there is not a result for search
            if isFiltering() && filteredPopular.isEmpty {
                setBehavior(newBehavior: .EmptySearch)
                tableView.reloadData()
            } else {
                setBehavior(newBehavior: .Success)
                tableView.reloadData()
            }
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
