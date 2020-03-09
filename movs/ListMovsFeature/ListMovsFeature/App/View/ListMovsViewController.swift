//
//  ListMovsViewController.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import CommonsModule
import AssertModule

enum ListMovsHandleState {
    case loading(Bool)
    case success(MovsListViewData)
    case failure
    case emptySearch(String)
}

open class ListMovsViewController: BaseViewController {
    
    var presenter: ListMovsPresenter!
    
    private let cellReuse = "GridCell"
    
    private var stateUI: ListMovsHandleState? {
        didSet {
            self.stateHandleUI()
        }
    }
    
    let emptySearchView: EmptySearchView = {
        let search = EmptySearchView()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let errorSearchView: ErrorSearchView = {
        let search = ErrorSearchView()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    
    lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 8, right: 10)
        
        let cellInLine: CGFloat = 2
        let width = self.view.bounds.width / ( cellInLine + 1.0 )
        let height = width * 1.5
        
        layout.itemSize = CGSize(width: width, height: height)

        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.register(ItemMovsCollectionViewCell.self, forCellWithReuseIdentifier: cellReuse)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    
    lazy var searchBarView: UISearchBar = {
        let view = UISearchBar()
        view.barTintColor = Colors.yellowLight
        view.searchTextField.backgroundColor = Colors.yellowDark
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.yellowLight.cgColor
        view.placeholder = "Search"
        view.image(for: .search, state: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.searchTextField.delegate = self
                
        return view
    }()
    
    let loadingView: UIActivityIndicatorView = {
        var view: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            view = UIActivityIndicatorView(style: .gray)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = Colors.yellowDark
        view.stopAnimating()
        return view
    }()
    
    var viewData: MovsListViewData?

}

//MARK: - Lifecycle-
extension ListMovsViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBarView()
        self.setupLoadingView()
        self.view.backgroundColor = Colors.whiteNormal
        self.navigationController?.navigationBar.barTintColor = Colors.yellowLight
        self.tabBarController?.tabBar.barTintColor = Colors.yellowLight
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.loading()
    }
}

//MARK: -State UI-
extension ListMovsViewController {
    private func stateHandleUI() {
        guard let state = self.stateUI else {return}
        switch state {
        case .loading(let isShowing):
            isShowing ? self.loadingView.startAnimating() : self.loadingView.stopAnimating()
        case .success(let successModel):
            self.setupSuccessView(with: successModel)
        case .failure:
            self.setupErrorView()
        case .emptySearch(let message):
            self.setupEmptyView(with: message)
        }
        self.presenter.tapOnButton()
    }
}

//MARK: -Action by Presenter-
extension ListMovsViewController: ListMovsView {
    
    
    func showSuccess(viewData: MovsListViewData) {
        self.stateUI = .success(viewData)
    }
    
    func showEmptyCard(message: String) {
        self.stateUI = .emptySearch(message)
    }
    
    func showErrorCard() {
        self.stateUI = .failure
    }
    
    func showLoading() {
        self.stateUI = .loading(true)
    }
    
    func hideLoading() {
        self.stateUI = .loading(false)
    }
    
    func setItemBar(image: UIImage?) {
        self.tabBarItem.image = image
    }
    
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func setItemBar(image: String) {        
        self.tabBarItem.image = UIImage(named: image,
                                        in: Bundle.main,
                                        compatibleWith: nil)
    }
}

//MARK: -Setup View-
extension ListMovsViewController {
     
    private func setupEmptyView(with message: String) {
        if !self.view.subviews.contains(self.errorSearchView) {
            self.view.addSubview(self.emptySearchView)
            self.setCenterViewConstraint(view: self.emptySearchView)
        }
        self.emptySearchView.message = message
    }
    
    private func setupErrorView() {
        if !self.view.subviews.contains(self.errorSearchView) {
            self.view.addSubview(self.errorSearchView)
            self.setCenterViewConstraint(view: self.errorSearchView)
        }
    }
    
    private func setupSuccessView(with viewData: MovsListViewData) {
        if !self.view.subviews.contains(self.gridView) {
            self.view.addSubview(self.gridView)
            self.setCenterViewConstraint(view: self.gridView)
        }
        self.viewData = viewData
        self.gridView.reloadData()
    }
    
    private func setupLoadingView() {
        if !self.view.subviews.contains(self.loadingView) {
            self.view.addSubview(self.loadingView)
            self.setCenterViewConstraint(view: self.loadingView)
        }
    }
    
    private func setupSearchBarView() {
        self.view.addSubview(self.searchBarView)
        NSLayoutConstraint.activate([
            self.searchBarView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            self.searchBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.searchBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.searchBarView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setCenterViewConstraint(view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

//MARK: - UITextFieldDelegate -
extension ListMovsViewController: UITextFieldDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }
}

//MARK: -Collection View DataSource -
extension ListMovsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewData?.items.count ?? 0
    }

    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let successCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuse, for: indexPath) as! ItemMovsCollectionViewCell
        self.loadImage(collectionView, at: indexPath)
        return successCell
    }
    
    private func loadImage(_ collectionView: UICollectionView, at indexPath: IndexPath) {
        if let itemViewData = self.viewData?.items[indexPath.item] {
            self.presenter.loadImage(with: itemViewData) { [weak self] data in
                if let data = data,
                    let cell = collectionView.cellForItem(at: indexPath) as? ItemMovsCollectionViewCell {
                    
                    self?.viewData?.items[indexPath.item].imageMovieData = data
                    cell.model = self?.viewData?.items[indexPath.item]
                    cell.posterUIImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
}
