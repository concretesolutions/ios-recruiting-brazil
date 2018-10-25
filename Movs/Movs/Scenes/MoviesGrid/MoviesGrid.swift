//
//  MoviesGrid.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MoviesGridDelegate:UICollectionViewDelegate {
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
        didSet { self.addSubview(self.collectionView) }
    }
    
    private var activityIndicator:UIActivityIndicatorView! {
        didSet { self.addSubview(self.activityIndicator) }
    }
    
    private var feedbackView:FeedbackView! {
        didSet { self.addSubview(self.feedbackView) }
    }
    
    var state: State = .loading {
        didSet { self.refreshUIAccordingToState() }
    }
    
    var movieItems:[MoviesGridCell.Data] = [] {
        didSet { self.collectionViewDataSource.items = self.movieItems }
    }
    
    weak var delegate:MoviesGridDelegate?
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    private func refreshUIAccordingToState() {
        switch self.state {
        case .loading:
            self.collectionView.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.feedbackView.isHidden = true
        case .error:
            self.collectionView.isHidden = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.feedbackView.isHidden = false
            self.feedbackView.image = Assets.errorIcon.image
            self.feedbackView.text = "Um erro ocorreu. Por favor, tente novamente."
        case .emptySearch:
            self.collectionView.isHidden = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.feedbackView.isHidden = false
            self.feedbackView.image = Assets.searchIcon.image
            self.feedbackView.text = "Não foi encontrado nenhum resultado para sua pesquisa."
        case .grid:
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.feedbackView.isHidden = false
        }
    }
}

extension MoviesGrid: ViewCode {
    
    func design() {
        // view
        self.backgroundColor = Colors.white.color
        // collection view
        self.collectionView = MoviesGridCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.setup()
        self.collectionView.dataSource = self.collectionViewDataSource
        // activity view
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        // feedback view
        self.feedbackView = FeedbackView()
        self.feedbackView.setup()
        // setup view acording to state
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
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.activityIndicator.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.activityIndicator.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.activityIndicator.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // background image view
        self.feedbackView.translatesAutoresizingMaskIntoConstraints = false
        self.feedbackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.feedbackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.feedbackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.feedbackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
