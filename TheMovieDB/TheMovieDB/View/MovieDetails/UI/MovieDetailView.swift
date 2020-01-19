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
import Combine

class MovieDetailView: UIScrollView {
    private var postImage = UIImageView.init()
    private var title = UILabel.init()
    private var releaseDate = UILabel.init()
    private var genre = UILabel.init()
    private var overviewText = UILabel.init()
    private(set) var favoriteButton = UIButton.init()
    private var scrollViewContainer = UIStackView.init()
    private let margin: CGFloat = 8
    private var subscriber: [AnyCancellable?] = []
    
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
        scrollViewContainer.addArrangedSubview(favoriteButton)
    }
    
    private func style() {
        backgroundColor = .primaryColor
        let font = UIFont.boldSystemFont(ofSize: 18)
        title.font = font
        title.textColor = .textColor
        title.numberOfLines = -1

        releaseDate.font = font
        releaseDate.textColor = .textColor
        releaseDate.numberOfLines = -1

        genre.font = font
        genre.textColor = .textColor
        genre.numberOfLines = -1

        overviewText.font = font
        overviewText.textColor = .textColor
        overviewText.numberOfLines = -1
        
        postImage.border(withRadius: 20)
        
        let titleButton = NSLocalizedString("Favorite", comment: "Title favorite button in detail view")
        favoriteButton.setTitle(titleButton, for: .normal)
        favoriteButton.backgroundColor = .primaryColorButton
        favoriteButton.setTitleColor(.textColorButton, for: .normal)
        favoriteButton.border(withRadius: 8)
        
        
        alwaysBounceHorizontal = false
        scrollViewContainer.axis = .vertical
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func movieIsFavorite(_ favorite: Bool) {
        if favorite {
            favoriteButton.setImage(UIImage.init(named: "tagfavorite"), for: .normal)
            favoriteButton.backgroundColor = .selectedButton
        }else {
            favoriteButton.setImage(UIImage.init(named: "tagfavorite"), for: .normal)
            favoriteButton.backgroundColor = .deselectedButton
        }
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
        superView.backgroundColor = .primaryColor
    }
    public func fillView(withMovie movie: Movie) {
        title.text = movie.title
        releaseDate.text = movie.releaseDate
        genre.text = placeholderGenres(withText: GenreViewModel.shared.filterGenres(withIDs: movie.genres).descriptionAllGenres())
        overviewText.text = movie.overview
        postImage.downloadImage(withPath: movie.posterPath, withDimension: .w342)
        movieIsFavorite(movie.isFavorite)
        subscriber.append(movie.notification.receive(on: DispatchQueue.main).sink { (_) in
            self.movieIsFavorite(movie.isFavorite)
            
        })
        subscriber.append(GenreViewModel.shared.notification.receive(on: DispatchQueue.main).sink { (_) in
            self.genre.text = self.placeholderGenres(withText: GenreViewModel.shared.filterGenres(withIDs: movie.genres).descriptionAllGenres())
        })
    }
    
    public func placeholderGenres(withText: String?) -> String {
        let template = NSLocalizedString("Genres", comment: "Genres description")
        if let text = withText {
            return "\(template): \(text)"
        } else {
            return "\(template): "
        }
    }
}
