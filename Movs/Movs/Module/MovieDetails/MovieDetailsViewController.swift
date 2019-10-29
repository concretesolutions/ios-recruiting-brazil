//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private let posterView = PosterImageView()
    private let titleLbl = UILabel()
    private let yearLbl = UILabel()
    private let genresLbl = UILabel()
    private let descriptionView = UITextView()
    
    var viewModel: MovieDetailsViewModel! {
        didSet {
            self.posterView.viewModel = PosterImageViewModel(with: self.viewModel.movie)
            self.titleLbl.text = self.viewModel.titleText
            self.yearLbl.text = self.viewModel.yearText
            self.genresLbl.text = self.viewModel.genresText
            self.descriptionView.text = self.viewModel.descriptionText
            
            self.navigationItem.rightBarButtonItem = self.favoriteBtn
        }
    }
    
    private lazy var favoriteBtn: UIBarButtonItem = {
        let image = self.viewModel.favoriteBtnImg
        let favoriteBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(MovieDetailsViewController.favoriteTapped))
        return favoriteBtn
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = "Movie"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLbl.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.titleLbl.numberOfLines = 2
        self.yearLbl.font = UIFont.preferredFont(forTextStyle: .headline)
        self.descriptionView.isEditable = false
        self.descriptionView.font = UIFont.preferredFont(forTextStyle: .body)

        self.view.addSubviews([self.posterView, self.titleLbl, self.yearLbl, self.genresLbl, self.descriptionView])
        UIView.translatesAutoresizingMaskIntoConstraintsToFalse(to: [self.posterView, self.titleLbl, self.yearLbl, self.genresLbl, self.descriptionView])
        // TODO: maybe set the poster's height relative to the superview's height?
        NSLayoutConstraint.activate([
            self.posterView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.posterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.posterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.posterView.heightAnchor.constraint(equalToConstant: 300),
            
            self.titleLbl.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 10),
            self.titleLbl.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.titleLbl.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            
            self.yearLbl.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor),
            self.yearLbl.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            
            self.genresLbl.bottomAnchor.constraint(equalTo: self.yearLbl.bottomAnchor),
            self.genresLbl.leadingAnchor.constraint(equalTo: self.yearLbl.trailingAnchor, constant: 10),
            self.genresLbl.trailingAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.trailingAnchor),
            
            self.descriptionView.topAnchor.constraint(equalTo: self.yearLbl.bottomAnchor, constant: 10),
            self.descriptionView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.descriptionView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.descriptionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    @objc func favoriteTapped() {
        self.viewModel.onFavoriteTapped()
        self.navigationItem.rightBarButtonItem?.image = self.viewModel.favoriteBtnImg
    }

}
