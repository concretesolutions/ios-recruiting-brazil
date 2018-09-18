//
//  MovieListViewController.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import UICollectionViewLeftAlignedLayout

class MovieListViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = MovieListPresenter()
    private var moviesData: [MovieData] = []
    private var loadActive: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.presenter.attach(view: self)
        self.presenter.loadMovieList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupCollectionView() {
        let flowLayout: UICollectionViewLeftAlignedLayout = UICollectionViewLeftAlignedLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 10 - 5, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.prepareCell(movie: self.moviesData[indexPath.row])
        if indexPath.row == self.moviesData.count - 1 && !self.loadActive {
            self.loadActive = true
            self.presenter.loadMoreMovieList()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.loadMovieDetail(movieData: self.moviesData[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func showProgress(show: Bool) {
        show ? self.showProgress() : self.hideProgress()
    }
    
    func showError(error: NSError) {
        self.showErrorSimple(error: error)
    }
    
    func onLoadedMovieList(entries: [MovieData]) {
        self.moviesData.append(contentsOf: entries)
        self.collectionView.reloadData()
        self.loadActive = false
    }

    func onLoadedMovieDetail(entry: MovieData) {
        MovieRouter.pushMovieDetailViewController(self, movie: entry)
    }
    
    func endPagination() {
        self.loadActive = false
    }
}
