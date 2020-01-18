//
//  MovieDetailsViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    weak var movie: Movie?
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    
    override func viewWillAppear(_ animated: Bool) {
        if let movie = self.movie {
            movieView.fillView(with: movie)
            NotificationCenter.default.addObserver(self, selector: #selector(updateBackdropImage), name: Movie.didDownloadBackdropImageNN, object: movie)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        movieView.cleanView()
        NotificationCenter.default.removeObserver(self)
    }
    
    // Private Types
    // Private Properties
    
    private var movieView: MovieDetailsView {
        return self.view as! MovieDetailsView
    }
    
    // Private Methods
    
    @objc private func updateBackdropImage() {
        DispatchQueue.main.async {
            self.movieView.backdropImageView.image = self.movie?.backdropImage
        }
    }
    
    @objc private func didTouchFavoriteButton() {
        if let movie = self.movie {
            movie.isFavorite = !movie.isFavorite
            movieView.fillView(with: movie)
        }
    }
    
    private func initController() {
        self.view = MovieDetailsView()
        
        movieView.scrollView.delegate = self
        movieView.favoriteMovieButton.addTarget(self, action: #selector(didTouchFavoriteButton), for: .touchUpInside)
    }
}

// MARK: - ScrollView Delegate
extension MovieDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let backdropHeight = UIScreen.main.bounds.width * (9.0 / 16.0)
        let y = backdropHeight - (scrollView.contentOffset.y + backdropHeight)
        let height = min(y, backdropHeight * 1.7)
        let top = min((y - backdropHeight) * 0.3, 0.0)
        movieView.backdropImageView.topConstraint?.constant = top
        movieView.backdropImageView.heightConstraint?.constant = height - top
    }
}
