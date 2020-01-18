//
//  FavoriteMovieTableViewCell.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class FavoriteMovieTableViewCell: UITableViewCell {
    // Static properties
    
    static let reuseIdentifier: String = "FavoriteMovieTableViewCell"
    static let rowHeight: CGFloat = (UIScreen.main.bounds.width / 3.0) * (3.0/2.0)
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(movie: Movie) {
        self.movie = movie
        
        posterImageView.image = movie.posterImage
        
        titleLabel.text = movie.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateLabel.text = dateFormatter.string(from: movie.releaseDate)
        
        overviewLabel.text = movie.overview
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePoster), name: Movie.didDownloadPosterImageNN, object: movie)
    }
    
    // Initialisation/Lifecycle Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    
    override func prepareForReuse() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Private Types
    // Private Properties
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let overviewLabel = UILabel()
    
    private weak var movie: Movie?
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            posterImageView,
            titleLabel,
            dateLabel,
            overviewLabel
        )
    }
    
    private func renderLayout() {
        let posterWidth = UIScreen.main.bounds.width / 3.0
        posterImageView.top(0).left(0).bottom(0).width(posterWidth)
        
        titleLabel.top(8).Left + 16 == posterImageView.Right
        titleLabel.Right - 16 == dateLabel.Left
        dateLabel.width(>=30).top(8).Right - 16 == Right
        align(horizontally: titleLabel, dateLabel)
        
        overviewLabel.right(16).Top + 8 == titleLabel.Bottom
        overviewLabel.bottom(8).Left + 16 == posterImageView.Right
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.selectionStyle = .none
        }
        
        titleLabel.style { (s) in
            s.numberOfLines = 2
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
        
        dateLabel.style { (s) in
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 15, weight: .light)
            s.textAlignment = .right
        }
        
        overviewLabel.style { (s) in
            s.numberOfLines = 7
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    @objc private func updatePoster() {
        DispatchQueue.main.async {
            self.posterImageView.image = self.movie?.posterImage
        }
    }
}
