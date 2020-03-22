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

open class HomeFavoriteMovsViewController: BaseViewController {
    
    var presenter: HomeFavoriteMovsPresenter!
    
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
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.loadingUI()
        self.setupSearchBarView()
        self.view.backgroundColor = Colors.whiteNormal
        
        self.navigationController?.navigationBar.barTintColor = Colors.yellowLight
        
        self.setupNavigationItem()
        
        self.tabBarController?.tabBar.barTintColor = Colors.yellowLight
    }
    
    @objc func tapOnFilterBarButtonItem() {
        print("FILTRANDO")
    }
    
    private func setupNavigationItem() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(Assets.Images.filterIcon, for: .normal)
        button.addTarget(self, action:#selector(tapOnFilterBarButtonItem), for: .touchDown)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
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
    func setTitle(_ text: String) {
        self.navigationItem.title = text
    }
}
