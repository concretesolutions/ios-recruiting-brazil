//
//  MoviesViewController.swift
//  Movies
//
//  Created by Renan Germano on 19/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, MoviesView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movies: MoviesCollectionView!
    
    
    // MARK: - Properties
    
    var presenter: MoviesPresentation!
    private var delegate: MoviesCVDelegate!
    private var dataSource: MoviesCVDataSource!
    private var searchDelegate: MoviesSearchBarDelegate!
    private var errorView: UIView!
    private var emptyView: UIView!

    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = MoviesCVDelegate(presenter: self.presenter)
        self.movies.delegate = self.delegate
        
        self.dataSource = MoviesCVDataSource(collectionView: self.movies, presenter: self.presenter)
        self.movies.dataSource = self.dataSource
        
        self.searchDelegate = MoviesSearchBarDelegate(presenter: self.presenter, viewController: self)
        self.searchBar.delegate = self.searchDelegate
        
        self.navigationItem.title = "Movies"
        self.showActivityIndicator()
        
        self.errorView = self.createView(withMessage: "Something went wrong. Please, try again. ")
        self.emptyView = self.createView(withMessage: "No registers found.")
        
        self.presenter.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }
    
    // MARK: - Aux functions
    
    private func createView(withMessage message: String) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let messageLabel = UILabel(frame: .zero)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)
        messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.view.addSubview(view)
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view.isHidden = true
        return view
    }
    
    private func present(view: UIView) {
        self.hideActivityIndicator()
        self.errorView.isHidden = true
        self.emptyView.isHidden = true
        self.movies.isHidden = true
        view.isHidden = false
        view.updateConstraints()
        
    }
    
    // MARK: - MoviesView protocol functions
    
    func present(movies: [Movie]) {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
            self.emptyView.isHidden = true
            self.movies.isHidden = false
            self.hideActivityIndicator()
            self.dataSource.update(movies: movies)
        }
    }
    
    func presentNew(movies: [Movie]) {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
            self.emptyView.isHidden = true
            self.movies.isHidden = false
            self.dataSource.add(movies: movies)
        }
    }
    
    func presentErrorView() {
        self.present(view: self.errorView)
    }
    
    func presentEmptyView() {
        self.present(view: self.emptyView)
    }
    

}
