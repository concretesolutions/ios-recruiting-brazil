//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 12/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class MovieDetailView: UIScrollView {
    private var postImage = UIImageView.init()
    private var title = UILabel.init()
    private var releaseDate = UILabel.init()
    private var genre = UILabel.init()
    private var overviewText = UILabel.init()
    private var scrollViewContainer = UIStackView.init()
    
    private let margin: CGFloat = 8
    
    init() {
        super.init(frame: .zero)
        subViews()
        style()
        autolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        sv(scrollViewContainer)
        
        scrollViewContainer.addArrangedSubview(postImage)
        scrollViewContainer.addArrangedSubview(title)
        scrollViewContainer.addArrangedSubview(releaseDate)
        scrollViewContainer.addArrangedSubview(genre)
        scrollViewContainer.addArrangedSubview(overviewText)
    }
    
    private func style() {
        backgroundColor = .primaryColor
        let font = UIFont.boldSystemFont(ofSize: 18)
        title.font = font
        title.textColor = .black
        title.numberOfLines = -1

        releaseDate.font = font
        releaseDate.textColor = .black
        releaseDate.numberOfLines = -1

        genre.font = font
        genre.textColor = .black
        genre.numberOfLines = -1

        overviewText.font = font
        overviewText.textColor = .black
        overviewText.numberOfLines = -1
        
        alwaysBounceHorizontal = false
        scrollViewContainer.axis = .vertical
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func autolayout() {
        scrollViewContainer.Top == self.Top
        scrollViewContainer.Bottom == self.Bottom
        scrollViewContainer.Leading == self.Leading
        scrollViewContainer.Trailing == self.Trailing
        scrollViewContainer.Width == self.Width
    }
    
    public func autolayoutSuperView() {
        guard let superView = self.superview else { return }
        self.Top == superView.safeAreaLayoutGuide.Top + margin
        self.Bottom == superView.safeAreaLayoutGuide.Bottom - margin
        self.Leading == superView.safeAreaLayoutGuide.Leading + margin
        self.Trailing == superView.safeAreaLayoutGuide.Trailing - margin
    }
    public func fillView(withMovie movie: Movie) {
        title.text = movie.title
        releaseDate.text = movie.releaseDate
        genre.text = "\(movie.genres)"
        overviewText.text = movie.overview
        postImage.downloadImage(withPath: movie.posterPath, withDimension: .w342)
    }
}
