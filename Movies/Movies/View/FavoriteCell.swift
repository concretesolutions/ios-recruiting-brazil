//
//  FavoriteCell.swift
//  Movies
//
//  Created by Jonathan Martins on 19/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"
    
    // The cell's icon
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // The movie's name
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's release date
    private let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Adds the constraints to the views in this cell
    private func setupConstraints(){
        
        self.contentView.addSubview(poster)
        self.contentView.addSubview(movieName)
        self.contentView.addSubview(movieDate)
        
        NSLayoutConstraint.activate([
            poster.heightAnchor .constraint(equalToConstant: 70),
            poster.widthAnchor  .constraint(equalToConstant: 50),
            poster.topAnchor    .constraint(equalTo: self.contentView.topAnchor, constant: 5),
            poster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            poster.bottomAnchor .constraint(equalTo: self.contentView.bottomAnchor, constant: -5),

            movieName.topAnchor     .constraint(equalTo: poster.topAnchor),
            movieName.leadingAnchor .constraint(equalTo: poster.trailingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            movieDate.topAnchor     .constraint(equalTo: movieName.bottomAnchor),
            movieDate.leadingAnchor .constraint(equalTo: movieName.leadingAnchor),
            movieDate.trailingAnchor.constraint(equalTo: movieName.trailingAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        self.contentView.backgroundColor = .white
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the Cell
    private var movie:Movie!
    private var delegate:MovieActionDelegate?
    func setupCell(movie:Movie, delegate:MovieActionDelegate?){
        self.movie    = movie
        self.delegate = delegate
        
        /// Sets the name of the cell
        movieName.text = self.movie.title
        
        /// Sets the release date of the cell
        movieDate.text = self.movie.releaseDate.formatDate(fromPattern: "yyyy-mm-dd", toPattern: "d MMMM yyyy")
        
        /// Sets the icon of the cell
        if let url = self.movie.poster{
            poster.load(url)
        }

        /// Adds the longpress action
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(favoriteAction)))
    }
    
    /// Action to favorite or unfavorite a movie
    @objc private func favoriteAction(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Unfavorite", style: .destructive, handler: { action in
            self.delegate?.onMovieFavorited(movie: self.movie, isFavorite: true)
        }))
    }
}
