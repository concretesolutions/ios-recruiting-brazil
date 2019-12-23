//
//  MoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class MoviesListViewController: UIViewController {
    let viewModel: MoviesListViewModel
    private let presentationManager: MovieListPresentationManager
    
    var scrollDirection: UICollectionView.ScrollDirection {
        get {
            return moviesListView.scrollDirection
        } set {
            moviesListView.scrollDirection = newValue
        }
    }
    
    lazy var moviesListView = MoviesListView(viewModel: viewModel, presentationManager: self.presentationManager).build {
        $0.delegate = self
    }
    
    init(viewModel: MoviesListViewModel, presentationManager: MovieListPresentationManager) {
        self.viewModel = viewModel
        self.presentationManager = presentationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubViews(moviesListView)
        
        moviesListView.layout.group
        .top(10).left(10).right(-10).bottom
        .fill(to: view.safeAreaLayoutGuide)
    }
    
    func viewForMovieAt(position: Int) -> UIView? {
        return moviesListView.viewForMovieAt(position: position)
    }
}
 
extension MoviesListViewController: MoviesListViewDelegate {
    func needShowError(withMessage message: String, retryCompletion: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
            retryCompletion()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
