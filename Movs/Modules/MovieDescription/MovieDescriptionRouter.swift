//
//  MovieDescriptionRouter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class MovieDescriptionRouter: MovieDescriptionWireframe {
    
    //MARK: - Contract Functions
    static func assembleModule(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?) -> UIViewController {
        
        let view = UIStoryboard(name: "MovieDescription", bundle: nil).instantiateViewController(withIdentifier: "MovieDescription") as? MovieDescriptionViewController
        
        let presenter = MovieDescriptionPresenter()
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.movie = movie
        presenter.genres = genres
        presenter.poster = poster
        
        return view!
        
    }
    
    
    
}
