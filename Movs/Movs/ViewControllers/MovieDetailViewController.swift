//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {

    let defaults = UserDefaults.standard
    let disposeBag = DisposeBag()
    var movieViewModel: MovieViewModel?
    var isFavorited: Bool = false
    var favoriteMoviesId: [Int] = []
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btFavorite: UIButton!
    
    @IBAction func addOrRemoveFavorite(_ sender: UIButton) {
        favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        
        if favoriteMoviesId.contains(movieViewModel!.id) {
            favoriteMoviesId = favoriteMoviesId.filter { $0 != movieViewModel!.id }
            defaults.set(favoriteMoviesId, forKey: "favoriteMoviesId")
            removeMoviesFromFavorites()
        } else {
            favoriteMoviesId.append(movieViewModel!.id)
            defaults.set(favoriteMoviesId, forKey: "favoriteMoviesId")
            addMovieToFavorites()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
        setupNavBar()
        
    }
    
    func setupUI() {
        
        self.lbMovieTitle.text = movieViewModel?.title
        self.lbMovieYear.text = movieViewModel?.releaseDate
        self.lbGenres.text = movieViewModel?.categories
        self.lbDescription.text = movieViewModel?.description
        
        self.imgMovie.lock(duration: 0)
        self.imgMovie.image = nil
        movieViewModel!.coverLocalPathObservable.subscribe(onNext: { coverLocalPath in
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
        
        favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        if favoriteMoviesId.contains(movieViewModel!.id) {
            addMovieToFavorites()
        } else {
            removeMoviesFromFavorites()
        }
    
    }
    
    func addMovieToFavorites(){
        isFavorited = true
        btFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
    }
    
    func removeMoviesFromFavorites() {
        isFavorited = false
        btFavorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
    }
    
    func setupNavBar(){
        navigationItem.largeTitleDisplayMode = .never
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
