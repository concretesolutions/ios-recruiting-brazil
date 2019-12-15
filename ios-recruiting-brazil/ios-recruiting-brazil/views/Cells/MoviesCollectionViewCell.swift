//
//  MoviesCollectionViewCell.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MoviesCollectionViewCell: UICollectionViewCell, ConfigView {

    var movie: MovieDTO?
    public weak var delegate: MovieCellDelegate?
    private var isFavorite = false
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let movieName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .yellow
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildCell() {
        guard let movie = movie else {
            return
        }
        self.movieName.text = movie.title
        setImage()
    }

    private func setImage() {
        guard let movie = movie else {
            return
        }
        let service = MovieService.getImage(movie.poster)
        let session = URLSessionProvider()
        session.request(type: Data.self, service: service) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.movieImage.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func favoriteButtonClicked() {
        if let movie = movie {
            delegate?.didFavoriteMovie(movie: movie, withImage: movieImage.image)
            isFavorite = !isFavorite
            isFavorite ? favoriteButton.setImage(
                UIImage(named: "favorite_full_icon"), for: .normal) :
                favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }

    func createViewHierarchy() {
        self.addSubview(movieImage)
        self.addSubview(wrapperView)
        self.addSubview(movieName)
        self.addSubview(favoriteButton)

    }
    func addConstraints() {
        //movieImage constraints
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        //movieName constraints
        NSLayoutConstraint.activate([
            movieName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieName.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor),
            movieName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            movieName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])

        //wrapperView constraints
        NSLayoutConstraint.activate([
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: movieName.topAnchor)
        ])

        //favoriteButton constraint
        let buttonHeight = favoriteButton.currentImage?.size.height ?? 50
        let buttonWidth = favoriteButton.currentImage?.size.width ?? 50
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            favoriteButton.centerYAnchor.constraint(equalTo: movieName.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            favoriteButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])

    }
}

extension  MoviesCollectionViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
