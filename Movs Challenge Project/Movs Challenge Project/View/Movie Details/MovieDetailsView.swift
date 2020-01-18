//
//  MovieDetailsView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class MovieDetailsView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let scrollView = UIScrollView()
    let backdropImageView = UIImageView()
    let favoriteMovieButton = UIButton(type: .custom)
    
    // Public Methods
    
    func fillView(with movie: Movie) {
        backdropImageView.image = movie.backdropImage
        
        titleLabel.text = movie.title
        
        favoriteIconImageView.image = movie.isFavorite ? .favoriteFullIcon : .favoriteGrayIcon
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateLabel.text = dateFormatter.string(from: movie.releaseDate)
        
        var genreString = ""
        movie.genreIds.forEach { (id) in
            if !genreString.isEmpty {
                genreString += ", "
            }
            genreString += Genres.list[id] ?? ""
        }
        genresLabel.text = genreString
        
        overviewLabel.text = movie.overview
    }
    
    func cleanView() {
        backdropImageView.image = nil
        titleLabel.text = nil
        favoriteIconImageView.image = .favoriteGrayIcon
        dateLabel.text = nil
        genresLabel.text = nil
        overviewLabel.text = nil
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
    // Private Types
    // Private Properties
    
    private let titleLabel = UILabel()
    private let favoriteIconImageView = UIImageView()
    private let dateLabel = UILabel()
    private let genresLabel = UILabel()
    private let overviewLabel = UILabel()
    
    private let backdropHeight = UIScreen.main.bounds.width * (9.0 / 16.0)
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            scrollView.sv(
                titleLabel,
                favoriteIconImageView,
                favoriteMovieButton,
                dateLabel,
                genresLabel,
                overviewLabel
            ),
            backdropImageView
        )
    }
    
    private func renderLayout() {
        scrollView.left(0).right(0).Top == safeAreaLayoutGuide.Top
        scrollView.Bottom == safeAreaLayoutGuide.Bottom
        
        titleLabel.height(>=24).top(8).Left + 16 == Left
        titleLabel.Right - 16 == favoriteIconImageView.Left
        favoriteIconImageView.size(24).Right - 16 == Right
        align(horizontally: titleLabel, favoriteIconImageView)
        
        favoriteMovieButton.top(0).Left == titleLabel.Right
        favoriteMovieButton.Bottom == titleLabel.Bottom
        favoriteMovieButton.Right == Right
        
        dateLabel.Top == titleLabel.Bottom + 8
        dateLabel.Left + 16 == Left
        dateLabel.Right - 16 == Right
        
        genresLabel.Top == dateLabel.Bottom + 8
        genresLabel.Left + 16 == Left
        genresLabel.Right - 16 == Right
        
        overviewLabel.Top == genresLabel.Bottom + 8
        overviewLabel.Left + 16 == Left
        overviewLabel.Right - 16 == Right
        
        backdropImageView.left(0).right(0).height(backdropHeight).Top == safeAreaLayoutGuide.Top
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
            s.tintColor = .mvYellow
        }
        
        scrollView.style { (s) in
            s.alwaysBounceVertical = true
            s.contentInset = UIEdgeInsets(top: backdropHeight, left: 0, bottom: 0, right: 0)
            s.contentSize.width = UIScreen.main.bounds.width
            s.backgroundColor = .mvBackground
        }
        
        titleLabel.style { (s) in
            s.numberOfLines = 2
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        }
        
        favoriteIconImageView.style { (s) in
            s.contentMode = .scaleAspectFit
            s.clipsToBounds = true
        }
        
        dateLabel.style { (s) in
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 15, weight: .light)
        }
        
        genresLabel.style { (s) in
            s.numberOfLines = 0
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        }
        
        overviewLabel.style { (s) in
            s.numberOfLines = 0
            s.textColor = .mvText
            s.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
        
        backdropImageView.style { (s) in
            s.contentMode = .scaleAspectFill
            s.clipsToBounds = true
            s.backgroundColor = .mvBackground
        }
    }
}
