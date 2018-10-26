//
//  MovieListViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol MovieListDisplayLogic: class {
    
}

class MovieListViewController: UIViewController, MovieListDisplayLogic {
    
    var interactor: MovieListBussinessLogic!
    var router: MovieListRoutingLogic!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 242)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        view.barTintColor = UIColor.Movs.yellow
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Movs.yellow.cgColor
        view.placeholder = "Search"
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func loadView() {
        setupViewController()
    }
    
    private func setup() {
        let viewController = self
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func setupViewController() {
        let view = UIView(frame: .zero)
        self.view = view
        title = "Movies"
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "ListIcon"), tag: 0)
        setupView()
    }
    
}

extension MovieListViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(64)
            make.height.equalTo(45)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        
        if let textFieldSearch = searchBar.value(forKey: "_searchField") as? UITextField {
            textFieldSearch.backgroundColor = UIColor.Movs.darkYellow
        }
    }
}

