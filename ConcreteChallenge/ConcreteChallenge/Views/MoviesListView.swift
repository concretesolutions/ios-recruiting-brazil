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
        toggleButton.layout.group.top.right.fillToSuperView()
        toggleButton.layout.build {
            $0.group.top.right.fillToSuperView()
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
            forCellType: MinimizedMovieCollectionCell.self,
            for: indexPath
        )
        
        movieCell.viewModel = viewModel.viewModelFromMovie(atPosition: indexPath.row)
        
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let movieCellWidth = (collectionView.frame.width - 3 * moviesCollectionLayout.minimumInteritemSpacing)/3
        return CGSize(width: movieCellWidth, height: movieCellWidth * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfMovies - 2 {
            viewModel.thePageReachedTheEnd()
        }
    }
}
