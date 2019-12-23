//
//  MoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

/// It has the responsability of listing movies. This will be reused in all the application.
/// A MoviesListViewController can have presention modes, this modes are ways the movies are showed at screen.
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
    
    
    /// Initilizes the MoviesListViewController
    /// - Parameters:
    ///   - viewModel: the viewModel that provides data to it.
    ///   - presentationManager: the presentation manager containing the presentation modes.
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
