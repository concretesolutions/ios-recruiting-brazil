//
//  MovieDetailsView.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

    private var viewModel: MovieDetailsViewModel!

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()

    @Published private var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage()  //Problem related with combine operators
        return imageView
    }()

    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blue
        return view
    }()

    private let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        label.text = "Teste"
        return label
    }()

    private let movieReleaseYear: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        return label
    }()

    private let movieOverview: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()

    required init(withViewModel viewModel: MovieDetailsViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        self.setupView()
        self.movieTitle.text = viewModel.title
        self.movieOverview.text = viewModel.overview
        self.movieReleaseYear.text = viewModel.releaseDate
        self.posterImageView.image = viewModel.posterImage
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieDetailsView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.posterImageView)
        self.scrollView.addSubview(self.containerView)
        self.containerView.addSubview(self.movieTitle)
        self.containerView.addSubview(self.movieOverview)
    }

    func setupContraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        self.posterImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalTo(self.snp.width)
            make.height.equalTo(200)
        }
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.posterImageView.snp.bottom)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(600)
        }
        self.movieTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(self.posterImageView.snp.bottom).offset(16)
        }
        self.movieOverview.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(self.movieTitle.snp.bottom).offset(16)
        }
    }

    func setupAdditionalConfiguration() {}
    
}
