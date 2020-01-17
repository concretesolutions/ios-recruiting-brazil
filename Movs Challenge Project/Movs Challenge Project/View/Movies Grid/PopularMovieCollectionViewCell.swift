//
//  PopularMovieCollectionViewCell.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 13/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class PopularMovieCollectionViewCell: UICollectionViewCell {
    // Static Properties
    
    static let reuseIdentifier: String = "PopularMovieCollectionViewCell"
    static private(set) var size: CGSize = .zero
    
    static private let infoHeight: CGFloat = 50
    
    // Static Methods
    
    static func setSize(screenSize: CGSize) {
        let width: CGFloat = (screenSize.width / 2.0) - (49.0 / 2.0)
        let height: CGFloat = width * (3.0/2.0) + PopularMovieCollectionViewCell.infoHeight
        PopularMovieCollectionViewCell.size = CGSize(width: width, height: height)
    }
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(movie: Movie) {
        self.movie = movie
        
        posterImageView.image = movie.posterImage
        titleLabel.text = movie.title
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePoster), name: Movie.didDownloadPosterImageNN, object: movie)
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    
    override var canBecomeFocused: Bool {
        return false
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        titleLabel.text = nil
        
        movie = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    // Private Types
    // Private Properties
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
    private weak var movie: Movie?
    
    // Private Methods
    
    @objc private func updatePoster() {
        DispatchQueue.main.async {
            self.posterImageView.image = self.movie?.posterImage
        }
    }
    
    private func renderSuperView() {
        sv(
            posterImageView,
            titleLabel
        )
    }
    
    private func renderLayout() {
        posterImageView.top(0).left(0).right(0)
        posterImageView.Bottom == titleLabel.Top
        
        titleLabel.bottom(0).left(16).right(16).height(PopularMovieCollectionViewCell.infoHeight)
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .darkGray
        }
        titleLabel.style { (s) in
            s.textAlignment = .center
            s.textColor = .mvYellow
            s.numberOfLines = 2
        }
    }
}
