//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Stevia
import Combine

class MovieCell: UICollectionViewCell {
    public static let identifier = "movieCellIdentifier"
    private var posterImage = UIImageView.init()
    private var title = UILabel.init()
    private var favoriteIcon = UIImageView.init()
    private let margin: CGFloat = 8
    private var subscriber: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
        autolayout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        sv(posterImage, title, favoriteIcon)
    }
    private func style() {
        self.border(withRadius: 8)
        backgroundColor = .clear
        let font = UIFont.systemFont(ofSize: 12)
        title.textColor = .textColor
        title.font = font
        title.numberOfLines = 2
        posterImage.image = UIImage.init(named: "placeholder-movies")
        posterImage.border(withRadius: 2, andColor: .black)
        favoriteIcon.image = UIImage.init(named: "tagfavorite")
    }
    
    private func autolayout() {
        let heightCell = (UIScreen.main.bounds.height / 3)
        let favoriteSpace = (heightCell / 4)
        
        posterImage.leading(margin).trailing(margin).top(margin)
        posterImage.height(heightCell - favoriteSpace)
        
        favoriteIcon.trailing(margin)
        favoriteIcon.Top == posterImage.Bottom + margin
        favoriteIcon.height(24).width(24)
        title.bottom(margin).leading(margin).Trailing == (favoriteIcon.Leading + margin)
        title.Top == posterImage.Bottom
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        posterImage.image = nil
    }
    public func isFavoriteMovie(_ status: Bool) {
        favoriteIcon.isHidden = !status

    }
    public func fill(withMovie movie: Movie) {
        subscriber?.cancel()
        title.text = movie.title
        posterImage.downloadImage(withPath: movie.posterPath, withDimension: .w185)
        isFavoriteMovie(movie.isFavorite)
        
        subscriber = movie.notification.receive(on: DispatchQueue.main).sink { (_) in
            self.title.text = movie.title
            self.posterImage.downloadImage(withPath: movie.posterPath, withDimension: .w185)
            self.isFavoriteMovie(movie.isFavorite)
        }
    }
}
