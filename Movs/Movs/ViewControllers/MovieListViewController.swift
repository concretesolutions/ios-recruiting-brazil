//
//  MovieListViewController.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import RxSwift

class MovieListViewController: UIViewController {

    var favoriteMovies: [MovieViewModel] = []
    let defaults = UserDefaults.standard
    
    //MARK: Variables
    private let disposeBag = DisposeBag()
    private let popularMoviesViewModel = PopularMoviesViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBar()
        
        setupPopularMoviesViewModelObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = defaults.array(forKey: "favoriteMovies") as? [MovieViewModel] ?? []
        collectionView.reloadData()
    }
    
    func setupNavBar(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: - Rx Setup
    private func setupPopularMoviesViewModelObserver() {
        popularMoviesViewModel.moviesObservable
            .subscribe(onNext: { movies in
                self.collectionView.reloadData()
                print(movies)
            })
            .disposed(by: disposeBag)
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            if let movieViewModel = sender as? MovieViewModel {
                vc.movieViewModel = movieViewModel
            }
        }
    }

}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMoviesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let movieViewModel = popularMoviesViewModel[indexPath.row]
        
        cell.movieViewModel = movieViewModel
        
        if favoriteMovies.contains(where: {$0.id == movieViewModel.id}) {
            cell.imgFavorite.image = UIImage(named: "favorite_full_icon")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showMovieDetail", sender: popularMoviesViewModel[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
