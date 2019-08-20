//
//  MovieGridController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit


//MARK: - Protocols
protocol MovieGridViewModelDelegate: class{
    func refreshMovieData()
}


class MovieGridController: UIViewController {
    
    let screen = MovieGridView()
    let viewModel: MovieGridViewModel
    
    //MARK: - Inits
    init(crud: FavoriteCRUDInterface, apiAcess: APIClientInterface) {
        viewModel = MovieGridViewModel(crud: crud,apiAcess: apiAcess)
        super.init(nibName: nil, bundle: nil)
        viewModel.refresh = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View cycle functions
    override func viewDidLoad(){
        self.view = screen
        
        navigationItem.title = "Movies"
        
        screen.gridView.delegate = self
        screen.gridView.dataSource = self
        screen.loadRoll.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        screen.gridView.reloadData()
    }
}


//MARK: - View Model delegate
extension MovieGridController: MovieGridViewModelDelegate{
    func refreshMovieData() {
        DispatchQueue.main.async { [weak self] in
            self?.screen.gridView.reloadData()
            self?.screen.loadRoll.stopAnimating()
            self?.screen.loadRoll.isHidden = true
            self?.screen.loadingLabel.isHidden = true
            self?.screen.gridView.isHidden = false
        }
    }
}


//MARK: - Transition
extension MovieGridController{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.row]
        
        let detailsVC = DetailsController(crud: viewModel.crud, selectedMovie: selectedMovie)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - CollectionView DataSource
extension MovieGridController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCell.reuseIdentifier, for: indexPath) as! MovieGridCell
        let movie = viewModel.movies[indexPath.row]
        let check = viewModel.checkFavorite(movieID: movie.id)
        cell.configure(withViewModel: movie, isFavorite: check)
    
        return cell
    }
}


//MARK: - CollectionView Layout
extension MovieGridController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // Loads more movies when the scrool gets near the end
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == viewModel.movies.count - 4){
            viewModel.loadMovies()
        }
    }
    
    // Distance to the screen sides
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5,left: 5,bottom: 0,right: 5)
    }
    // Set the size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 280)
    }
}

