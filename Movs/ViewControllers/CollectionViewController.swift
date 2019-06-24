//
//  CollectionViewController.swift
//  Movs
//
//  Created by Filipe Merli on 19/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, Alerts {
// MARK: - Properties
    private var viewModel: MoviesViewModel!
    private let collection = "mcell"
    private let itemsPerRow: CGFloat = 2
    private let numOfSects = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var shouldShowLoadingCell = false
    
// MARK: - ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        viewModel = MoviesViewModel(delegate: self)
        viewModel.fetchPopularMovies()
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let soma = (indexPath.section * 2) + 3 // Aqui eu chamo o fectch 3 celulas antes de chegar no final da collection
        return soma >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    func findGens(genIds: [Int]) -> String {
        var finalGenString = ""
        for i in 0..<genIds.count {
            finalGenString.append(contentsOf: viewModel.findGen(from: genIds[i]))
            if i != (genIds.count - 1) {
                finalGenString.append(contentsOf: ", ")
            }
        }
        return finalGenString
    }
    
}
// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.currentCount > 0 {
            return numOfSects
        }else{
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numOfMovs = viewModel.currentCount
        if (numOfMovs > 0) {
            if (numOfMovs % 2 == 0) {
                return (numOfMovs / 2)
            } else{
                return ((numOfMovs + 1) / 2)
            }
        }else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collection, for: indexPath) as! MovsCollectionViewCell
        if (viewModel.currentCount > 0) {
            var cellIndex: Int = 0
            if (indexPath.row == 0) {
                cellIndex = (indexPath.section * 2)
            } else{
                cellIndex = ((indexPath.section * 2) + 1)
            }
            cell.setCell(with: viewModel.movie(at: cellIndex))
        } else {
            cell.setCell(with: .none)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cellIndex: Int = 0
        if (indexPath.row == 0) {
            cellIndex = (indexPath.section * 2)
        } else{
            cellIndex = ((indexPath.section * 2) + 1)
        }
        let movieToPresent = viewModel.movie(at: cellIndex)
        let cats = findGens(genIds: movieToPresent.generedIds)
        let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetailVC") as! DetailMovieViewController
        movieDetailVC.movie = movieToPresent
        movieDetailVC.genres = cats
        if let navVC = self.navigationController {
            navVC.pushViewController(movieDetailVC, animated: true)
        }else {
            let navVC = UINavigationController(rootViewController: movieDetailVC)
            present(navVC, animated: true, completion: nil)
        }
    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching
extension CollectionViewController: MoviesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.collectionView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
        }
        let title = "Alerta"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension CollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPopularMovies()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: (widthPerItem * 1.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

// MARK: - UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    
}
