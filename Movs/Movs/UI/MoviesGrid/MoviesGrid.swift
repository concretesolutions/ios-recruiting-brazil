//
//  MoviesGrid.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MoviesGridDelegate:AnyObject {
}

final class MoviesGrid: UIView {
    
    enum State {
        case loading
        case error
        case emptySearch
        case grid
    }
    
    private let collectionViewDataSource = MoviesGridDataSource()
    
    private var collectionView:MoviesGridCollectionView! {
        didSet {
            self.collectionView.setupView()
            self.collectionView.dataSource = self.collectionViewDataSource
            self.collectionView.delegate = self
            self.addSubview(self.collectionView)
        }
    }
    
    private var feedbackView:MoviesGridFeedbackView! {
        didSet {
            self.feedbackView.setupView()
            self.addSubview(self.feedbackView)
        }
    }
    
    private var activityIndicatorView:UIActivityIndicatorView! {
        didSet {
            self.addSubview(self.activityIndicatorView)
        }
    }
    
    var state: State = .loading {
        didSet {
            self.refreshUIAccordingToState()
        }
    }
    
    var movieItems:[MoviesGridCell.Data] = [] {
        didSet {
            self.collectionViewDataSource.items = self.movieItems
        }
    }
    
    weak var delegate:MoviesGridDelegate?
    
    private func refreshUIAccordingToState() {
        switch self.state {
        case .loading:
            self.collectionView.isHidden = true
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
            self.feedbackView.isHidden = true
        case .error:
            self.collectionView.isHidden = true
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.feedbackView.isHidden = false
            self.feedbackView.image = Assets.errorIcon.image
            self.feedbackView.text = "Um erro ocorreu. Por favor, tente novamente."
        case .emptySearch:
            self.collectionView.isHidden = true
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.feedbackView.isHidden = false
            self.feedbackView.image = Assets.searchIcon.image
            self.feedbackView.text = "Não foi encontrado nenhum resultado para sua pesquisa."
        case .grid:
            self.collectionView.isHidden = false
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.feedbackView.isHidden = false
        }
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension MoviesGrid: ViewCode {
    
    func design() {
        self.backgroundColor = Colors.white.color
        self.collectionView = MoviesGridCollectionView(frame: .zero, collectionViewLayout: MoviesGridFlowLayout())
        self.activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.feedbackView = MoviesGridFeedbackView()
        self.refreshUIAccordingToState()
    }
    
    func autolayout() {
        // collection view
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // activity indicator
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.activityIndicatorView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.activityIndicatorView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // background image view
        self.feedbackView.translatesAutoresizingMaskIntoConstraints = false
        self.feedbackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.feedbackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.feedbackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.feedbackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension MoviesGrid: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MoviesGridFlowLayout.calculateItemSize(for: collectionView.bounds.size)
    }
}
