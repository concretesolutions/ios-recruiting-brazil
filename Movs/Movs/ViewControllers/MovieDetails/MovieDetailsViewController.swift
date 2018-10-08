//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    enum Constants {
        static let nibName = "MovieDetailsViewController"
    }

    @IBOutlet weak var imageHeight: NSLayoutConstraint!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbDescription: UILabel!

    private var presenter: MovieDetailsPresenter

    init(movie: Movie) {
        presenter = MovieDetailsPresenter(movie: movie)
        super.init(nibName: Constants.nibName, bundle: nil)
        presenter.view = self
        self.title = movie.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        let image = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
        let rightButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(onFavoriteButtonTapped)
        )
        navigationItem.rightBarButtonItem = rightButtonItem

        presenter.onStart()
    }

    @objc private func onFavoriteButtonTapped() {
        presenter.onFavoriteAction()
    }

    private func setupViews() {
        imageHeight.constant = UIScreen.main.bounds.width - 16
    }
}

extension MovieDetailsViewController: MovieDetailsView {

    func setup(with movie: Movie) {
        lbYear.text = movie.releaseDate
        lbDescription.text = movie.overview
    }

    func presenter(_ presenter: MovieDetailsPresenter, didFetchImage image: UIImage) {
        self.imageView.image = image
    }

    func setFavorite(to favorite: Bool) {
        if favorite {
            let image = UIImage(named: "buttonUnfavorite")?.withRenderingMode(.alwaysTemplate)
            let rightButtonItem = UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: #selector(onFavoriteButtonTapped)
            )
            rightButtonItem.tintColor = UIColor.red
            navigationItem.rightBarButtonItem = rightButtonItem
        } else {
            let image = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
            let rightButtonItem = UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: #selector(onFavoriteButtonTapped)
            )
            rightButtonItem.tintColor = UIColor.black
            navigationItem.rightBarButtonItem = rightButtonItem
        }
    }
}
