//
//  MoviesScreen.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class MoviesScreen: UIView {
    // MARK: - Subviews
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self.controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie by name"
        return searchController
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self.controller,
                                 action: #selector(self.controller?.reloadCollectionView),
                                 for: .valueChanged)
        return refreshControl
    }()
    
    lazy var moviesCollectionView: UICollectionView = {
        // Setup collection view layout
        let cellSpacing: CGFloat = 16
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: cellSpacing,
                                           left: cellSpacing,
                                           bottom: cellSpacing,
                                           right: cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        // Setup cell size
        /// The width of a cell is equal to the size of the device minus the left,
        /// right and between cells spacing, divided by two (two cells per row)
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - 3*16)/2
        layout.itemSize = CGSize(width: cellWidth,
                                 height: cellWidth*1.5)

        // Setup collection view
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.backgroundColor = .systemGray6
        view.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        view.dataSource = self.controller
        view.delegate = self.controller
        view.refreshControl = self.refreshControl
        return view
    }()
    
    // MARK: - Delegate
    weak var controller: MoviesController?
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, controller: MoviesController) {
        self.controller = controller
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exception view
    func showErrorView() {
        DispatchQueue.main.async {
            self.moviesCollectionView.backgroundView = ExceptionView(imageNamed: "Error",
                                                                     title: "An error has occurred. Please try again")
        }
    }
    
    func presentEmptySearch(_ shouldPresent: Bool) {
        if shouldPresent {
            DispatchQueue.main.async {
                self.moviesCollectionView.backgroundView = ExceptionView(imageNamed: "EmptySearch",
                                                                         title: "Your search returned no results")
            }
        } else {
            DispatchQueue.main.async {
                self.moviesCollectionView.backgroundView = nil
            }
        }
    }
}

extension MoviesScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(moviesCollectionView)
    }
    
    func setupConstraints() {
        self.moviesCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
        self.controller?.navigationItem.searchController = self.searchController
    }
}
