//
//  MoviesGridView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MoviesGridViewDelegate:AnyObject {
    func moviesGrid(_ sender:MoviesGridView, didSelectItemAt indexPath:IndexPath)
    func moviesGrid(_ sender:MoviesGridView, didFavoriteItemAt indexPath:IndexPath)
    func moviesGrid(_ sender:MoviesGridView, didUnfavoriteItemAt indexPath:IndexPath)
}

final class MoviesGridView: UIView {
    
    enum State {
        case loading
        case error
        case emptySearch
        case grid
    }
    
    private lazy var collectionViewDataSource = MoviesGridDataSource(cellDelegate: self)
    
    private var collectionView:MoviesGridCollectionView! {
        didSet {
            self.collectionView.setupView()
            self.collectionView.dataSource = self.collectionViewDataSource
            self.collectionView.delegate = self
            self.addSubview(self.collectionView)
        }
    }
    
    private var feedbackView:FeedbackView! {
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
    
    var movieItems:[Movie] = [] {
        didSet {
            self.collectionViewDataSource.items = self.movieItems
        }
    }
    
    weak var delegate:MoviesGridViewDelegate?
    
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
            self.reloadData()
        }
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func collectionViewIndexPath(for cell:MoviesGridCell) -> IndexPath {
        return self.collectionView.indexPath(for: cell)!
    }
}

extension MoviesGridView: ViewCode {
    
    func design() {
        self.backgroundColor = Colors.white.color
        self.feedbackView = FeedbackView()
        self.activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.collectionView = MoviesGridCollectionView(frame: .zero, collectionViewLayout: MoviesGridFlowLayout())
        self.refreshUIAccordingToState()
    }
    
    func autolayout() {
        self.collectionView.fillAvailableSpaceInSafeArea()
        self.activityIndicatorView.fillAvailableSpaceInSafeArea()
        self.feedbackView.fillAvailableSpaceInSafeArea()
    }
}

extension MoviesGridView: MoviesGridCellDelegate {
    
    func didFavoriteCell(_ sender: MoviesGridCell) {
        self.delegate?.moviesGrid(self, didFavoriteItemAt: self.collectionViewIndexPath(for: sender))
    }
    
    func didUnfavoriteCell(_ sender: MoviesGridCell) {
        self.delegate?.moviesGrid(self, didUnfavoriteItemAt: self.collectionViewIndexPath(for: sender))
    }
}

extension MoviesGridView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.moviesGrid(self, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MoviesGridFlowLayout.calculateItemSize(for: collectionView.bounds.size)
    }
}
