//
//  MoviesTableTableViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import RxSwift
import ReSwift

class PopularMoviesCollectionViewController: UICollectionViewController {
    let reuseIdentifier = "PopularMovieCell"

    var movies: [Movie] = []
    var genres: [Genre] = []

    var loading: Bool = false
    var displayFooter: Bool = false
    var isLastPage: Bool = false
    var error: String = ""

    var backgroundStateView: BackgroundStateView!

    let disposeBag = DisposeBag()

    var isSearching: Bool!
    var filters: MovieFilters!

    let searchController = UISearchController(searchResultsController: nil)

    var loadingFooterState: LoadingFooterState = .hidden
    var loadingMoreFooter: LoadingMoreFooterCollectionReusableView! = LoadingMoreFooterCollectionReusableView()
    let loadingMoreFooterNibName = "LoadingMoreFooterCollectionReusableView"
    let loadingMoreFooterCellIdentifier = "LoadingMoreFooterCollectionReusableView"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupCollectionViewLayout()
        setupSearchBar()

    }

    fileprivate func setupCollectionView() {
        self.collectionView!.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        self.backgroundStateView = BackgroundStateView()
        self.backgroundStateView.retryDelegate = self

        self.collectionView!.backgroundView = self.backgroundStateView

        self.collectionView!.register(
            UINib(nibName: loadingMoreFooterNibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: loadingMoreFooterCellIdentifier
        )
    }

    fileprivate func setupCollectionViewLayout() {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.footerReferenceSize = self.displayFooter ? CGSize(width: collectionView.bounds.width, height: 263) : .zero
        }
    }

    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar
            .rx.text
            .debounce(Constants.api.searchDebounceTime, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] _ in
                let text = self.searchController.searchBar.text!
                do {
                    let filters = try self.filters.clone()
                    if text.isEmpty {
                        filters.search(for: nil)
                    } else {
                        filters.search(for: text)
                    }
                    filters.resetPagination()
                    filters.appyFilters()
                } catch {
                    print("Error cloning filter: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    fileprivate func setupNavigationBar() {
        guard let navigationController = self.navigationController else { return }

        let bgColor = UIColor(asset: .brand)

        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = bgColor
        navigationController.view.backgroundColor = bgColor

        navigationController.navigationBar.tintColor = .darkGray

        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.backgroundColor = bgColor
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17)
        ]

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { $0.select(PopularMoviesViewModel.init) }
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter && self.displayFooter {

            loadingMoreFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: loadingMoreFooterCellIdentifier,
                for: indexPath
                ) as? LoadingMoreFooterCollectionReusableView

            guard loadingMoreFooter != nil else {
                return UICollectionReusableView()
            }

            switch self.loadingFooterState {
            case .loading:
                loadingMoreFooter.showLoading()
            case .thatsAll:
                loadingMoreFooter.showThatsAllFolks()
            default:
                break
            }

            return loadingMoreFooter
        }
        return UICollectionReusableView()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularMovieCollectionViewCell

        cell.setup(with: self.movies[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsCollectionViewController(collectionViewLayout: StretchyHeaderLayout())
        let movie = movies[indexPath.row]
        movieDetailsVC.movieId = movie.id
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // One line before the last one
        if indexPath.row == movies.count - 2 && !self.isLastPage {
            self.filters.loadNextPage()
        }
    }

}

extension PopularMoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.contentSize.width - 30) / 2
        return CGSize(width: size, height: size * (720 / 500) + 75)
    }
}

extension PopularMoviesCollectionViewController: EmptyStateRetryDelegate {
    func executeRetryAction(_ sender: EmptyStateView) {
        do {
            let filters = try self.filters.clone()
            filters.appyFilters()
        } catch {
            print("Error cloning filter: \(error.localizedDescription)")
        }
    }
}

extension PopularMoviesCollectionViewController: StoreSubscriber {

    func newState(state: PopularMoviesViewModel) {

        if let backgroundViewConfiguration = state.backgroundViewConfiguration {
            backgroundStateView.showEmptyState(with: backgroundViewConfiguration)
        } else if state.loading {
            backgroundStateView.showLoading()
        } else {
            backgroundStateView.clear()
        }

        let shouldRefresh = self.movies != state.movies || state.loading || state.isSearching

        self.genres = state.genres
        self.movies = state.movies
        self.loading = state.loading
        self.filters = state.filters
        self.isSearching = state.isSearching
        self.isLastPage = state.isLastPage

        switch state.loadingFooterState {
        case .loading:
            self.displayFooter = true
        case .thatsAll:
            self.displayFooter = true
        default:
            self.displayFooter = false
        }

        if self.loadingFooterState != state.loadingFooterState {
            self.loadingFooterState = state.loadingFooterState
            setupCollectionViewLayout()
        }

        if shouldRefresh {
            self.collectionView!.reloadData()
        }
    }
}
