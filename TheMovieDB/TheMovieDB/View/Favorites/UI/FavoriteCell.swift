//
//  FavoriteCell.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 18/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import UIKit
import Stevia

class FavoriteCell: UITableViewCell {
    
    public var posterImage = UIImageView.init()
    public var titleMovie = UILabel.init()
    public var favoriteButton = UIButton.init()
    public static let identifier = "favoriteCellIdentifier"
    
    private var margin: CGFloat = 8
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subViews()
        self.style()
        autolayout()
    }
    
    private func subViews() {
        sv(posterImage, titleMovie, favoriteButton)
    }
    
    private func style() {
        favoriteButton.setImage(UIImage.init(named: "tagfavorite"), for: .normal)
    }
    
    private func autolayout() {
        posterImage.top(margin).bottom(margin).leading(margin).width(30%).height(90%)
        favoriteButton.centerVertically().trailing(margin).height(30%)
        titleMovie.centerVertically()
        titleMovie.Leading == posterImage.Trailing + margin
        titleMovie.Trailing == favoriteButton.Leading + margin
    }
    
    public func fill(withMovie movie: Movie) {
        titleMovie.text = movie.title
        guard let path = movie.posterPath else { return }
        posterImage.downloadImage(withPath: path, withDimension: .w154)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
