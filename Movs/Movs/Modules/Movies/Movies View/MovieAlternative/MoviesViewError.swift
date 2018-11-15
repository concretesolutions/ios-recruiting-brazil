//
//  MoviesViewError.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 12/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesViewError: UIView {
    
    var movieView: MoviesView?
   
    func setup(movieView: MoviesView) {
        self.movieView = movieView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("-> Reload")
        if let view = movieView {
            view.presenter.fetchMovies()
        }
    }
    
}
