//
//  MovieCell.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import RxSwift

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    private let disposeBag = DisposeBag()
    private let defaults = UserDefaults.standard
    var isFavorited: Bool = false
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var btFavorite: UIButton!
    
    var movieViewModel: MovieViewModel! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        lbMovieTitle.text = movieViewModel.title
    
        let favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        btFavorite.setImage(favoriteMoviesId.contains(movieViewModel.id) ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon"), for: .normal)
    
        print(movieViewModel.title)
        
        self.imgMovie.lock(duration: 0)
        self.imgMovie.image = nil
        movieViewModel.coverLocalPathObservable.subscribe(onNext: { coverLocalPath in
            guard let coverLocalPath = coverLocalPath else { return }
            
            do {
                let url = URL(fileURLWithPath: coverLocalPath)
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                self.imgMovie.image = image
            } catch {
                self.imgMovie.image = UIImage(named: "movieNegative")
                print(error)
            }
            self.imgMovie.unlock()
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        let favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        
        if favoriteMoviesId.contains(movieViewModel!.id) {
            removeMovieFromFavorites()
        } else {
            addMovieToFavorites()
        }
    }
    
    fileprivate func markMovieAsFavorite(){
        isFavorited = true
        btFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
    }
    
    fileprivate func unmarkMovieAsFavorite(){
        isFavorited = false
        btFavorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
    }
    
    fileprivate func addMovieToFavorites(){
        FirebaseAnalyticsHelper.addFavoriteEventLogger(movieId: movieViewModel!.id, movieTitle:movieViewModel!.title)
        movieViewModel.isFavorited = true
        FavoriteMovie.addFavoriteMovie(movieViewModel: movieViewModel!)
        markMovieAsFavorite()
    }
    
    fileprivate func removeMovieFromFavorites() {
        FirebaseAnalyticsHelper.removeFavoriteEventLogger(movieId: movieViewModel!.id, movieTitle:movieViewModel!.title)
        movieViewModel.isFavorited = false
        FavoriteMovie.removeFavoriteMovie(id: movieViewModel!.id)
        unmarkMovieAsFavorite()
    }
}
