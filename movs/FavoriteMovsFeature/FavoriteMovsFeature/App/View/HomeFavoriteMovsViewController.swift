//
//  HomeFavoriteMovsViewController.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 22/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule
import CommonsModule
import ModelsFeature

open class HomeFavoriteMovsViewController: BaseViewController {
    
    var presenter: HomeFavoriteMovsPresenter!
    var dataSourceTableView = HomeFavoriteMovsDataSource()
    var delegateTableView = HomeFavoriteMovsDelegate()
    
    
    private var searchBarView: UISearchBar = {
        let view = UISearchBar()
        view.barTintColor = Colors.yellowLight
        
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.yellowLight.cgColor
        view.placeholder = "Search"
        view.image(for: .search, state: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellDefault")
        tableView.register(HomeFavoriteItemCell.self, forCellReuseIdentifier: HomeFavoriteItemCell.reuseCell)
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = Colors.whiteNormal
        return tableView
    }()
    
    
}

//MARK: - Lifecycle
extension HomeFavoriteMovsViewController{
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearchBarView()
        self.view.backgroundColor = Colors.whiteNormal
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.loadingUI()
    }
}

//MARK: - setups UI
extension HomeFavoriteMovsViewController {
    
    @objc func tapOnFilterBarButtonItem() {
        print("FILTRANDO")
    }
    
    private func setupTableView() {
        favoriteTableView.delegate = self.delegateTableView
        favoriteTableView.dataSource = self.dataSourceTableView
        
        
        self.delegateTableView.selected = { indexPath in
            let favoriteViewData = self.dataSourceTableView.favorites[indexPath.row]
            self.presenter.selected(favoriteModel: favoriteViewData)
        }
        
        self.dataSourceTableView.removed = { favoriteView in
            self.presenter.remove(at: favoriteView)
        }        
        
        self.view.addSubview(favoriteTableView)
        
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor, constant: 4),
            favoriteTableView.trailingAnchor.constraint(equalTo: self.searchBarView.trailingAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: self.searchBarView.leadingAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: self.bottomAnchorSafeArea),
        ])
    }
    
    private func setupNavigationBar() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(Assets.Images.filterIcon, for: .normal)
        button.addTarget(self, action:#selector(tapOnFilterBarButtonItem), for: .touchDown)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationController?.navigationBar.barTintColor = Colors.yellowLight
        self.tabBarController?.tabBar.barTintColor = Colors.yellowLight
    }
    
    private func setupSearchBarView() {
        if #available(iOS 13.0, *) {
            self.searchBarView.searchTextField.backgroundColor = Colors.yellowDark
//            self.searchBarView.searchTextField.delegate = self
        }
//        self.searchBarView.delegate = self
        
        self.view.addSubview(self.searchBarView)
        NSLayoutConstraint.activate([
            self.searchBarView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            self.searchBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.searchBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.searchBarView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

//MARK: - Binding Presenter
extension HomeFavoriteMovsViewController: HomeFavoriteMovsView {
    func loadDatas(_ favoriteMovsModel: HomeFavoriteViewData) {
        self.navigationItem.title = favoriteMovsModel.title
        self.dataSourceTableView.favorites = favoriteMovsModel.favorites
        self.favoriteTableView.reloadData()
    }
}
