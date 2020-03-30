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
    case searching(String)
    case reloadData(MovsListViewData)
    case favoriteMovie(MovsItemViewData)
    case showDetail(MovsItemViewData)
}

open class ListMovsViewController: BaseViewController {
    
    var presenter: ListMovsPresenter!
    
    private let cellReuse = "GridCell"
    
    var stateUI: ListMovsHandleState? {
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
        let width = (self.view.bounds.width / ( cellInLine + 1.0 ) ) + 35 //Right + Left + Between
        let height = width * 1.5
        
        layout.itemSize = CGSize(width: width, height: height)

        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.register(ItemMovsCollectionViewCell.self, forCellWithReuseIdentifier: cellReuse)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    
     var searchBarView: UISearchBar = {
        let view = UISearchBar()
        view.barTintColor = Colors.yellowLight
        
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.yellowLight.cgColor
        view.placeholder = "Search"
        view.image(for: .search, state: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
    var firstView: Bool = true
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
        
        self.presenter.loading()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        if !firstView {
            self.presenter.appearView()
        } else {
            firstView = false
        }
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
        
        case .reloadData(let successModel):
            self.viewData = successModel
            self.gridView.reloadData()
        
        case .searching(let searching):
            self.searchBarView.resignFirstResponder()
            self.presenter.searchingModel(searching)
        
        case .favoriteMovie(let itemView):
            self.presenter.favoriteMovie(itemView)
            self.searchBarView.resignFirstResponder()
            
        case .showDetail(let itemView):
            self.presenter.showDetail(itemView)
        }
    }
}

//MARK: -Action by Presenter-
extension ListMovsViewController: ListMovsView {
    func updateViewData(_ viewData: MovsListViewData) {
        self.viewData = viewData
    }
    
    func reloadData(with viewData: MovsListViewData) {
        self.stateUI = .reloadData(viewData)
    }
    
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
        self.navigationItem.title = text
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
        if #available(iOS 13.0, *) {
            self.searchBarView.searchTextField.backgroundColor = Colors.yellowDark
            self.searchBarView.searchTextField.delegate = self
        }
        self.searchBarView.delegate = self
        
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
        guard let search = searchBar.text else { return }
        self.stateUI = .searching(search)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.stateUI = .searching("")
        }
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            self.stateUI = .searching("")
        }
    }
}

extension ListMovsViewController: UISearchBarDelegate {
}


//MARK: -Collection View DataSource -
extension ListMovsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewData?.items.count ?? 0
    }

    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let successCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuse, for: indexPath) as! ItemMovsCollectionViewCell
        if let itemViewData = self.viewData?.items[indexPath.item] {
            successCell.model = itemViewData
            successCell.favoriteMovie = { itemView in                
                self.stateUI = .favoriteMovie(itemView)
            }
        }
        
        return successCell
    }
}

//MARK: -Collection View Delegate-
extension ListMovsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.viewData?.items[indexPath.item] else { return }
        self.stateUI = .showDetail(item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemMovsCollectionViewCell {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemMovsCollectionViewCell {
                cell.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
}
