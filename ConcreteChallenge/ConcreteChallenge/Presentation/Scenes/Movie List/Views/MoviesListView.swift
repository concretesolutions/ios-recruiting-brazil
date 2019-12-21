//
//  MoviesListView.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MoviesListView: UIView, ViewCodable {
    let viewModel: MoviesListViewModel
    weak var delegate: MoviesListViewDelegate?
    
    private let moviesCollectionLayout = UICollectionViewFlowLayout()
    private lazy var moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: moviesCollectionLayout).build {
        $0.registerReusableCell(forCellType: MinimizedMovieCollectionCell.self)
        $0.registerReusableCell(forCellType: MaximizedMovieCollectionCell.self)
        $0.dataSource = self
        $0.delegate = self
        $0.contentInset.top = 50
    }
    private lazy var toggleButton = ToggleButton(firstImage: UIImage(named: "grid")!, secondImage: UIImage(named: "expanded")!).build {
        $0.wasToggledCompletion = { [weak self] firstOptionIsSelected in
            self?.viewModel.viewStateChanged()
        }
    }
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        addSubViews(moviesCollectionView, toggleButton)
    }
    
    func addConstraints() {
        moviesCollectionView.layout.fillSuperView()
        toggleButton.layout.build {
            $0.group.top(5).right(-5).fillToSuperView()
            $0.width.equal(to: 140)
            $0.height.equal(to: 40)
        }
    }
    
    func observeViewModel() {
        viewModel.needShowNewMovies = { [weak self] newMoviesRange in
            DispatchQueue.main.async {
                self?.moviesCollectionView.insertItemsInRange(newMoviesRange)
            }
        }
        
        viewModel.needShowError = { [weak self] errorMessage in
            self?.delegate?.needShowError(withMessage: errorMessage) {
                self?.viewModel.thePageReachedTheEnd()
            }
        }
        
        viewModel.needReloadAllMovies = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
            }
        }
        
        viewModel.thePageReachedTheEnd()
    }
}

extension MoviesListView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = moviesCollectionView.dequeueReusableCell(
            forCellType: viewModel.mustShowGridMode ? MinimizedMovieCollectionCell.self : MaximizedMovieCollectionCell.self,
            for: indexPath
        )
        
        if let movieView = movieCell as? MovieView {
            movieView.viewModel = viewModel.viewModelFromMovie(atPosition: indexPath.row)
        }
                
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridMode = viewModel.mustShowGridMode
        
        let numberOfColumns: CGFloat = gridMode ? 3 : 1
        let movieCellHeightFactor: CGFloat = gridMode ? 1.5 : 1.2
        
        let movieCellWidth = (collectionView.frame.width - numberOfColumns * moviesCollectionLayout.minimumInteritemSpacing)/numberOfColumns
        return CGSize(width: movieCellWidth, height: movieCellWidth * movieCellHeightFactor)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfMovies - 2 {
            viewModel.thePageReachedTheEnd()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userSelectedMovie(atPosition: indexPath.row)
    }
}
