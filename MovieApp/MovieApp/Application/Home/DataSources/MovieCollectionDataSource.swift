//
//  MovieCollectionDataSourceswift
//  MovieApp
//
//  Created by Giuliano Accorsi on 11/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//


import UIKit

protocol MovieDataSourceDelegate: class {
    func didScroll()
    func didSelected(movie: Movie)
    func favoriteMovie(movie: Movie)
}

final class MovieCollectionDataSource: NSObject {
    
    private weak var collectionView: UICollectionView?
    private let delegate: MovieDataSourceDelegate
    private var movies: [Movie] = []
    
    init(collectionView: UICollectionView, delegate: MovieDataSourceDelegate) {
        self.delegate = delegate
        super.init()
        self.collectionView = collectionView
        registerCells()
        setupDataSource()
    }
    
    private func registerCells() {
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: Strings.movieCell)
    }
    
    private func setupDataSource() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    func updateMovies(movies: [Movie]) {
        self.movies = movies
        collectionView?.reloadData()
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
    
}

extension MovieCollectionDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screeWidth: CGFloat = UIScreen.main.bounds.width / 2 - 15
        return CGSize(width: screeWidth, height: 1.5 * screeWidth)
    }
}

extension MovieCollectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelected(movie: movies[indexPath.item])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tagertContentOffSet = ((collectionView?.contentSize.height ?? 0) - (collectionView?.frame.height ?? 0))
        if scrollView.contentOffset.y * 2 > tagertContentOffSet {
            delegate.didScroll()
        }
    }
}

extension MovieCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.movieCell, for: indexPath) as? MovieCell else { return UICollectionViewCell()}
        let movie = movies[indexPath.item]
        cell.setupCell(movie: movie, index: indexPath.item, isFavorite: MovieDataManager().isMovieFavorite(id: movie.id))
        cell.delegate = self
        return cell
    }
    
}


extension MovieCollectionDataSource: MovieCellDelegate {
    func tapped(index: Int) {
        delegate.favoriteMovie(movie: movies[index])
    }
}

