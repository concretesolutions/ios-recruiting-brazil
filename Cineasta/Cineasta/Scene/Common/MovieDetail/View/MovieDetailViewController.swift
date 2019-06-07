//
//  MovieDetailViewController.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    // MARK: - OUTLETS -
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var generLabel: UILabel!
    @IBOutlet weak var genreActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - VARIABLES -
    private var presenter: MovieDetailPresenter!
    public lazy var viewData = MovieViewData()
    
    // MARK: - IBACTIONS -
    @IBAction func backViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - LIFE CYCLE -
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieDetailPresenter(viewDelegate: self)
        self.presenter.getGenres(genreIds: self.viewData.genreIds)
        self.setupView()
    }
    
    override func viewWillLayoutSubviews() {
        backButton.titleLabel!.baselineAdjustment = UIBaselineAdjustment.alignCenters
    }
}

// MARK: - PRESENTER -
extension MovieDetailViewController: MovieDetailViewDelegate {
    func showLoadingGenre() {
        self.generLabel.alpha = 0
        UIView.animate(withDuration: 0.4, animations: { [unowned self] in
            self.genreActivityIndicator.alpha = 1
            self.genreActivityIndicator.startAnimating()
        })
    }
    
    func showGenre(genre: String) {
         self.generLabel.text = genre
        UIView.animate(withDuration: 0.4, animations: {
            self.generLabel.alpha = 1
            self.genreActivityIndicator.alpha = 0
            self.genreActivityIndicator.stopAnimating()
        })
    }
}

// MARK: - AUX METHODS -
extension MovieDetailViewController {
    private func setupView() {
        self.setShadow(view: self.mainView, height: 0, alpha: 0.1)
        self.setShadow(view: self.posterImageView, height: 3, alpha: 0.3)
        self.setImage(imageView: self.backdropImageView, url: self.viewData.backdropURL, title: self.viewData.title+"back")
        self.setImage(imageView: self.posterImageView, url: self.viewData.posterURL, title: self.viewData.title+"poster")
        self.titleLabel.text = self.viewData.title
        self.favoriteImageView.tintColor = self.viewData.isFavorite ? Constants.Colors.selectedAsFavorite : Constants.Colors.unselectedAsFavorite
        self.releaseDateLabel.text = self.viewData.releaseDate
        self.overviewLabel.text = self.viewData.overview
        self.addGesture()
    }
    
    private func setShadow(view: UIView, height: CGFloat, alpha: CGFloat) {
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: height)
        view.layer.shadowColor = UIColor.black.withAlphaComponent(alpha).cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
    }
    
    private func setImage(imageView: UIImageView, url: String, title: String) {
        let url = URL(string: url)
        let options: KingfisherOptionsInfo = [.transition(.fade(1)), .cacheOriginalImage]
        imageView.kf.setImage( with: url, placeholder: UIImage(named: title), options: options)
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectOrUnselectAsFavoriteFilm))
        self.favoriteView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func selectOrUnselectAsFavoriteFilm() {
        self.viewData.isFavorite ? self.unselectAsFavorite() : self.selectAsFavorite()
    }
    
    private func selectAsFavorite() {
        self.viewData.isFavorite = true
        UserDefaulstHelper.shared.saveOrUpdateFavoriteList(movie: self.viewData, forKey: Constants.UserDefaultsKey.favoriteList)
        self.favoriteImageViewAnimation(color: Constants.Colors.selectedAsFavorite)
    }
    
    private func unselectAsFavorite() {
        self.viewData.isFavorite = false
        UserDefaulstHelper.shared.removeFavorite(movie: self.viewData, forKey: Constants.UserDefaultsKey.favoriteList)
        self.favoriteImageViewAnimation(color: Constants.Colors.unselectedAsFavorite)
    }
    
    private func favoriteImageViewAnimation(color: UIColor) {
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.favoriteView.transform = .init(scaleX: 1.4, y: 1.4)
            }, completion: { [unowned self] _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.favoriteView.transform = .identity
                    self.favoriteImageView.tintColor = color
                })
        })
    }
}
