//
//  MovieListViewController.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import RxSwift
import Lottie

class MovieListViewController: UIViewController {

    //MARK: Variables
    private var favoriteMoviesId: [Int] = []
    private let defaults = UserDefaults.standard
    private let disposeBag = DisposeBag()
    private let popularMoviesViewModel = PopularMoviesViewModel()
    
    //MARK: IB Outlets
    @IBOutlet weak var vwLoading: UIView!
    @IBOutlet weak var vwLoadingAnimation: UIView!
    @IBOutlet weak var vwError: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        vwError.isHidden = true
        
        let loadingAnimation = LOTAnimationView(name: "loading")
        loadingAnimation.frame = CGRect(x: 0, y: 0, width: vwLoadingAnimation.frame.size.width, height: vwLoadingAnimation.frame.size.height)
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.loopAnimation = true
        vwLoadingAnimation.addSubview(loadingAnimation)
        loadingAnimation.play(completion: { finished in
            print("rodando animacao")
        })
        
        vwLoading.isHidden = false
        
        setupPopularMoviesViewModelObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        collectionView.reloadData()
    }
    
    //MARK: - Rx Setup
    private func setupPopularMoviesViewModelObserver() {
        popularMoviesViewModel.moviesObservable
            .subscribe(onNext: { movies in
                self.collectionView.reloadData()
                print(movies)
                self.vwLoading.isHidden = movies.count > 0
                
            }, onError: { error in
                print(error)
                self.vwError.isHidden = false
            })
            .disposed(by: disposeBag)
    }
    
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            if let movieViewModel = sender as? MovieViewModel {
                vc.movieViewModel = movieViewModel
            }
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView stubs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMoviesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let movieViewModel = popularMoviesViewModel[indexPath.row]
        
        cell.movieViewModel = movieViewModel
        
        favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        if favoriteMoviesId.contains(movieViewModel.id) {
            cell.btFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            cell.btFavorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
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
        
        return CGSize(width: yourWidth, height: yourHeight * 1.5)
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
