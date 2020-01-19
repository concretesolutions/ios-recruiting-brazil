//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 12/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    public var movieViewModel: MovieViewModel = {
        return MovieViewModel.shared
    }()
    public var genresViewModel: GenreViewModel = {
        return GenreViewModel.shared
    }()
    private var detailView = MovieDetailView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigation()
        guard let movie = movieViewModel.selectedMovie else { return }
        detailView.fillView(withMovie: movie)
        view.addSubview(detailView)
        detailView.autolayoutSuperView()
        detailView.favoriteButton.addTarget(self,
                                            action: #selector(selectFavoriteMovie), for: .touchUpInside)
    }
    
    @objc
    private func selectFavoriteMovie() {
        movieViewModel.changeFavorite()
    }
        
    private func styleNavigation() {
        self.title = NSLocalizedString("Details", comment: "Title Movie Details")
    }
}
