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
    case success
    case failure
    case emptySearch(String)
}

open class ListMovsViewController: BaseViewController {
    
    var presenter: ListMovsPresenter!
    
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
    
    lazy var successSearchView: MovsSearchView = {
        let search = MovsSearchView(model: 3)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let searchBarView: UISearchBar = {
        let view = UISearchBar()
        view.barTintColor = Colors.yellowLight
        view.searchTextField.backgroundColor = Colors.yellowDark
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

}

//MARK: - Lifecycle-
extension ListMovsViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBarView()
        self.setupLoadingView()
        self.searchBarView.delegate = self
                
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
        case .success:
            self.setupSuccessView()
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
    
    func loadViewController() {
        self.view.backgroundColor = Colors.whiteNormal
        //self.stateUI = .emptySearch("Batman é melhor que Bruce Waynner")        
        self.stateUI = .success
    }
}

//MARK: -Setup View-
extension ListMovsViewController {
     
    private func setupEmptyView(with message: String) {
        if !self.view.subviews.contains(self.errorSearchView) {
            self.view.addSubview(self.emptySearchView)
            self.setCenterViewConstraint(view: self.emptySearchView)
        }
        self.emptySearchView.setMessageNotFound(message)
    }
    
    private func setupErrorView() {
        if !self.view.subviews.contains(self.errorSearchView) {
            self.view.addSubview(self.errorSearchView)
            self.setCenterViewConstraint(view: self.errorSearchView)
        }
    }
    
    private func setupSuccessView() {
        if !self.view.subviews.contains(self.successSearchView) {
            self.view.addSubview(self.successSearchView)
            self.setCenterViewConstraint(view: self.successSearchView)
        }
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


//MARK: - UISearchBarDelegate -
extension ListMovsViewController: UISearchBarDelegate {
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }
}

