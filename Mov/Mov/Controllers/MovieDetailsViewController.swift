//
//  MovieDetailsViewController.swift
//  Mov
//
//  Created by Victor Leal on 19/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    let screen = MovieDetailsViewControllerScreen()
    var moviesViewController: MoviesViewController!
    var movie: Result!
    let userDefaults = SalvedDatas.shared
    
    override func loadView() {
        
        self.view = screen
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        screen.title.text = movie.title ?? "Título não econtrado"
        screen.year.text = movie.releaseDate ?? "Data não econtrada"
        screen.genre.text = movie.genreIDS?.description ?? "Gênero não encontrado"
        screen.movieDescription.text = movie.overview ?? "Descrição não econtrada"
        
        setsFavoriteButton()
    }
    
    func setsFavoriteButton(){
        
        screen.favoriteButton.addTarget(self, action:#selector(favorite), for: UIControl.Event.touchUpInside)
        if let titleMovie = movie.title, let fav = favoriteMovies[titleMovie]{
            if fav{
                screen.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
            }else{
                screen.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
            }
            moviesViewController.reloadCollectionView()
        }
        
        
    }
    
    @objc func favorite(){
        
        if let title = movie.title, let fav = favoriteMovies[title]{
            var favoriteMoviesUserDefaults = userDefaults.favoriteMovies
            
            if fav{
                favoriteMoviesUserDefaults = favoriteMoviesUserDefaults.filter{$0 != title}
                screen.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
            }else{
                favoriteMoviesUserDefaults.append(title)
                screen.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
            }
            favoriteMovies[title] = !favoriteMovies[title]!
            userDefaults.favoriteMovies = favoriteMoviesUserDefaults
            
            
            
            // print(userDefaults.favoriteMovies)
        }
        
    }
    
    
}

