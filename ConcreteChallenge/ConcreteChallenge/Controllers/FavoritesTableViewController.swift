//
//  Favorites.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import ReSwift
import RxSwift

class FavoritesTableViewController: UITableViewController {

    @IBOutlet weak var filterBarButton: UIBarButtonItem!

    let disposeBag = DisposeBag()

    var favorites: [Favorite] = []
    var filters: FavoriteFilters!
    var genres: [Genre]!
    var genresOptions: [String]!
    var yearsOptions: [String]!

    let searchController = UISearchController(searchResultsController: nil)

    var backgroundStateView: BackgroundStateView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        tableView.rowHeight = 118

        self.backgroundStateView = BackgroundStateView()
        self.backgroundStateView.retryDelegate = self
        tableView!.backgroundView = self.backgroundStateView

        setupSearchBar()
    }

    fileprivate func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController

        searchController.searchBar
            .rx.text
            .debounce(Constants.api.localSearchDebounceTime, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] _ in
                let text = self.searchController.searchBar.text!
                do {
                    let filters = try self.filters.clone()
                    if text.isEmpty {
                        filters.search(with: nil)
                    } else {
                        filters.search(with: text)
                    }

                    filters.appyFilters()
                } catch {
                    print("Error cloning filter: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17)
        ]

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }

    @IBAction func filterAction(_ sender: Any) {
        do {
            let filterVc = FilterTableViewController()
            filterVc.filters = try self.filters.clone()
            filterVc.genres = self.genres
            filterVc.genresOptions = self.genresOptions
            filterVc.yearsOptions = self.yearsOptions

            filterVc.modalPresentationStyle = .popover
            let navController = UINavigationController(rootViewController: filterVc)

            self.navigationController?.present(navController, animated: true, completion: nil)
        } catch let error {
            print("Fail cloning filters \(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell

        cell.accessoryType = .disclosureIndicator
        cell.set(with: favorites[indexPath.row])

        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { $0.select(FavoritesViewModel.init) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favorites[indexPath.row].remove()
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsCollectionViewController(collectionViewLayout: StretchyHeaderLayout())
        movieDetailsVC.movieId = favorites[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }

}

extension FavoritesTableViewController: EmptyStateRetryDelegate {
    func executeRetryAction(_ sender: EmptyStateView) {
        do {
            let filters = try self.filters.clone()
            filters.appyFilters()
        } catch {
            print("Error cloning filter: \(error.localizedDescription)")
        }
    }
}
extension FavoritesTableViewController: StoreSubscriber {
    func newState(state: FavoritesViewModel) {
        if let backgroundViewConfiguration = state.backgroundViewConfiguration {
            backgroundStateView.showEmptyState(with: backgroundViewConfiguration)
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
        } else {
            backgroundStateView.clear()
            tableView.separatorStyle = .singleLine
            tableView.isScrollEnabled = true
        }

        let shouldUpdate = self.favorites != state.favorites

        self.favorites = state.favorites
        self.genres = state.genres
        self.genresOptions = state.genresOptions
        self.yearsOptions = state.yearsOptions

        if self.filters != state.filters {
            self.filters = state.filters
        }
//        self.genres = state.genresNames

        if !self.tableView.isEditing && shouldUpdate {
            let range = NSRange(location: 0, length: self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        }

    }
}
