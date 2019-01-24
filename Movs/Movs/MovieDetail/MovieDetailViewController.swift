//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView(frame: .zero)
    var viewModel: MovieDetailViewModel?

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        title = viewModel.title
        movieDetailView.genresLabel.text = viewModel.genres
        movieDetailView.titleLabel.text = viewModel.title
        movieDetailView.overviewLabel.text = viewModel.overview
        guard let image = viewModel.image else { return }
        Nuke.loadImage(with: image, into: movieDetailView.imageView)

    }
}

extension MovieDetailViewController: ViewConfiguration {
    func setupViews() {

    }

    func setupHierarchy() {
        view.addSubview(movieDetailView)
    }

    func setupConstraints() {
        movieDetailView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view).inset(10)
        }
    }
}
