//
//  MovieCell.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol MovieCellDelegate {
    func downloadImage(to model: MovieModel, completion: @escaping (ResponseResultType<Data>, String) -> Void)
}

class MovieCell: UICollectionViewCell {

    static let cellSize = CGSize(width: 150, height: 260)
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    @IBOutlet private weak var posterActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var placeHolderLabel: UILabel!
    
    var model: MovieModel? {
        didSet {
            setupView()
        }
    }
    
    var delegate: MovieCellDelegate?
    
    override func prepareForReuse() {
        posterImage.image = nil
        movieTitleLabel.text = nil
        movieReleaseDate.text = nil
        delegate = nil
    }

    private func setupView() {
        setMovieTitle()
        setMovieReleaseDate()
        setupPosterImage()
    }
    
    private func setMovieTitle() {
        movieTitleLabel.text = model?.title
    }
    
    private func setMovieReleaseDate() {
        if let releaseDate = model?.releaseDate {
            movieReleaseDate.text = "Lançado em: \(releaseDate)"
            movieReleaseDate.isHidden = false
        } else {
            movieReleaseDate.isHidden = true
        }
    }
    
    private func setupPosterImage() {
        guard let model = model else { return }
        if let posterImageData = model.posterImageData {
            setPoster(with: posterImageData)
        } else {
            downloadPosterImage(with: model)
        }
    }
    
    private func downloadPosterImage(with model: MovieModel) {
        showLoading()
        delegate?.downloadImage(to: model) { [weak self] result, path in
            if model.posterPath == path {
                switch result {
                case let .success(imageData):
                    self?.model?.posterImageData = imageData
                    self?.setPoster(with: imageData)
                case .fail(_):
                    self?.setPlaceHolder()
                }
            }
        }
    }
    
    private func setPoster(with imageData: Data) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.placeHolderLabel.isHidden = true
            self.posterImage.image = UIImage(data: imageData)
        }
    }
    
    private func setPlaceHolder() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.placeHolderLabel.isHidden = false
        }
    }
    
    private func showLoading() {
        posterActivityIndicator.isHidden = false
        posterActivityIndicator.startAnimating()
    }
    
    private func hideLoading() {
        posterActivityIndicator.isHidden = true
        posterActivityIndicator.stopAnimating()
    }
}
