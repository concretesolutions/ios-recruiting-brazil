//
//  MoviesListCell.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit

protocol MoviesListDelegate: class {
    func buttonFavorite(movies: ResultMoviesDTO, cell: MoviesListCell)
}

class MoviesListCell: UICollectionViewCell {
    
    weak var delegate: MoviesListDelegate!
    
    var movie: ResultMoviesDTO!
    
    let photo: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Title of film"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var favorite: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        button.addTarget(self, action: #selector(btnFavorite(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnFavorite(sender: Any) {
        delegate.buttonFavorite(movies: movie, cell: self)
    }
}

extension MoviesListCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(photo)
        addSubview(title)
        addSubview(favorite)
    }
    
    func setupConstraints() {
        photo.layout.applyConstraint { view in
            view.topAnchor(equalTo: topAnchor)
            view.leadingAnchor(equalTo: leadingAnchor)
            view.trailingAnchor(equalTo: trailingAnchor)
            view.heightAnchor(equalTo: 250)
        }
        
        title.layout.applyConstraint { view in
            view.topAnchor(equalTo: photo.bottomAnchor)
            view.leadingAnchor(equalTo: leadingAnchor, constant: 8)
            view.bottomAnchor(equalTo: bottomAnchor)
        }
        
        favorite.layout.applyConstraint { view in
            view.topAnchor(equalTo: photo.bottomAnchor)
            view.trailingAnchor(equalTo: trailingAnchor, constant: -8)
            view.bottomAnchor(equalTo: bottomAnchor)
        }
    }
}

extension MoviesListCell {
    func addComponents(with movie: ResultMoviesDTO) {
        self.movie = movie
        photo.downloadImage(from: (Constants.pathPhoto + movie.poster_path))
        title.text = movie.title
    }
}
