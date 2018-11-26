//
//  MovieDetailPresenter.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MovieDetailPresenter: NSObject {
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router: MovieDetailRouter
    var interactor: MovieDetailInteractor
    var view: MovieDetailViewController
    
    // MARK: - Initializers
    init(router: MovieDetailRouter, interactor: MovieDetailInteractor, view: MovieDetailViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        //
        self.view.set(title: self.interactor.movie.title!)
        self.view.set(overview: self.interactor.movie.overview!)
        self.view.set(age: self.interactor.movie.releaseDate!)
        self.view.set(genreTitles: self.interactor.genreTitles())
        
        ImageManager.shared.fetchImage(from: self.interactor.movie.posterPath!) { (result) in
            switch result {
            case .success(let image):
                self.view.set(poster: image)
            case .failure(let error):
                self.router.showAlert(message:error.localizedDescription)
            }
        }
    }
    
    func didSet(isFavorite:Bool) {
        self.interactor.movie.isFavorited = isFavorite
    }
}
