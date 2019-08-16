//
//  MovieGridController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit

//MARK: - Controller of the MovieGrid Screen
class MovieGridController: UIViewController {
    
    let screen = MovieGridView()
    let viewModel = MovieGridViewModel()
    
    override func viewDidLoad(){
        self.view = screen
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movies"
        
        screen.gridView.delegate = self
        screen.gridView.dataSource = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }
    
    func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.screen.gridView.reloadData()
            self?.screen.gridView.layoutIfNeeded()
        }
    }
}

//MARK: - Calls the details screen when a movie is selected
extension MovieGridController{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.row]
        
        let detailsVC = DetailsController()
        detailsVC.viewModel.movie = selectedMovie
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Collection DataSource Methods
extension MovieGridController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCell.reuseIdentifier, for: indexPath) as! MovieGridCell
        let movie = viewModel.movies[indexPath.row]
        let favImage = viewModel.checkFavorite(movieID: movie.id)
        cell.configure(withViewModel: movie, favImage: favImage)
        return cell
    }
}



//MARK: - Collection Layout Methods
extension MovieGridController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // Loads more movies when the scrool gets near the end
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == viewModel.movies.count - 4){
            viewModel.loadMovies { [weak self] (hasLoaded) in
                if hasLoaded {
                    self?.refreshData()
                }
            }
        }
    }
    
    // Distance to the screen sides
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
    // Set the size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 280)
    }
}

