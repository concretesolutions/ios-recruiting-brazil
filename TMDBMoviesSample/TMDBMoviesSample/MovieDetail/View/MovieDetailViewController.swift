//
//  MovieDetailViewController.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseYearLabel: UILabel!
    @IBOutlet private weak var genresListLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favButton: UIButton!
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var genreActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var genrePlaceHolder: UILabel!
    
    @IBAction private func favAction(_ sender: Any) { presenter.setFavorite() }
    
    private lazy var presenter: MoviePresenterProtocol = MovieDetailPresenter(with: self)
    
    var model: MovieDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupViews()
        presenter.setupFavoriteState()
    }
}

//MARK: - SetupMethods -
extension MovieDetailViewController {
    private func setupTitle() {
        title = model?.title
    }
    
    private func setupViews() {
        guard let model = model else { return }
        titleLabel.text = model.title
        releaseYearLabel.text = model.releaseYear
        descriptionLabel.text = model.description
        if let imageData = model.posterData {
            backdropImageView.image = UIImage(data: imageData)
        }
        presenter.getGenreList()
    }
}

//MARK: - ViewProtocol methods -
extension MovieDetailViewController: MovieDetailViewProtocol {
    func showGenreLoading() {
        DispatchQueue.main.async {
            self.genrePlaceHolder.isHidden = false
            self.genresListLabel.isHidden = true
            self.genreActivityIndicator.startAnimating()
            self.genreActivityIndicator.isHidden = false
        }
    }
    
    func hideGenreLoading() {
        DispatchQueue.main.async {
            self.genrePlaceHolder.isHidden = true
            self.genreActivityIndicator.isHidden = true
            self.genreActivityIndicator.stopAnimating()
            self.genresListLabel.isHidden = false
        }
    }
    
    func setGenreText(with text: String?) {
        DispatchQueue.main.async {
            self.genresListLabel.text = text
        }
    }
    
    func setFavEnable() {
        let image = UIImage(named: "ic_fav")
        favButton.setImage(image, for: .normal)
    }
    
    func setFavDisable() {
        let image = UIImage(named: "ic_fav_disable")
        favButton.setImage(image, for: .normal)
    }
}
