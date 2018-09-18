//
//  PopularMoviesView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class PopularMoviesView: UIView {
    
    /// The collectionView which holds the movies
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 150, height: 300)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    /// The RefreshControl that indicates when the list is updating
    let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

    // Adds the constraints to this view
    private func setupConstraints(){
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MovieCell: UICollectionViewCell{
    
    static let identifier = "MovieCell"
    
    // The cell's icon
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // The movie's name
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's release date
    private let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Indicates if the movie is favorite
    private let favoriteIcon: UIImageView = {
        let icon   = UIImageView()
        icon.image = UIImage(named: "icon_favorite")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    /// Adds the constraints to the views in this cell
    private func setupConstraints(){
        
        self.addSubview(poster)
        self.addSubview(movieName)
        self.addSubview(movieDate)
        self.addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            poster.heightAnchor  .constraint(equalToConstant: 70),
            poster.topAnchor     .constraint(equalTo: self.contentView.topAnchor, constant: 5),
            poster.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            poster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            favoriteIcon.widthAnchor   .constraint(equalToConstant: 15),
            favoriteIcon.heightAnchor  .constraint(equalToConstant: 15),
            favoriteIcon.topAnchor     .constraint(equalTo: poster.topAnchor),
            favoriteIcon.trailingAnchor.constraint(equalTo: poster.trailingAnchor),
            
            movieName.topAnchor     .constraint(equalTo: self.poster.bottomAnchor, constant: 5),
            movieName.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            movieDate.topAnchor     .constraint(equalTo: self.movieName.bottomAnchor, constant: 5),
            movieDate.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            movieDate.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            movieDate.bottomAnchor  .constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the Cell
    func setupCell(movie:Movie){
        
        /// Sets the name of the cell
        movieName.text = movie.title
        
        /// Sets the release date of the cell
        movieDate.text = movie.releaseDate
        
        /// Sets the icon of the cell
        if let url = movie.poster{
            poster.load(url)
        }
    }
}

