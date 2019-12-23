//
//  MaximizedMovie.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A cell made to fill a big space on screen
class MaximizedMovieCollectionCell: UICollectionViewCell, ViewCodable, MovieViewCell {
    var viewModel: MovieViewModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }

            oldValue?.movieViewWasReused()

            handleMovieViewModel(viewModel)
            
            if let favoriteViewModel = self.favoriteViewModel {
                handleFavoritesViewModel(favoriteViewModel)
            }
        }
    }
    
    var favoriteViewModel: MovieViewModelWithFavoriteOptions? {
        return viewModel as? MovieViewModelWithFavoriteOptions
    }
    
    private let headerBackgroundView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let headerContentView = UIView().build {
        $0.backgroundColor = UIColor.appPurple.withAlphaComponent(0.8)
    }
    var movieImageView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().build {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .appTextPurple
    }
    private let genresLabel = UILabel().build {
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .appTextBlue
    }
    private let releaseLabel = UILabel().build {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .white
    }
    private lazy var faveImageView = FavoriteImageView(
        imagesForState: [.faved: UIImage(named: "faved")!, .unfaved: UIImage(named: "unfaved")]).build {
        $0.favoriteButtonTapCompletion = { [weak self] in
             self?.favoriteViewModel?.usedTappedToFavoriteMovie()
        }
    }
    private let footerView = UIView().build {
        $0.backgroundColor = UIColor.appPurple.withAlphaComponent(0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        addSubViews(headerBackgroundView, headerContentView, movieImageView, footerView)
        headerContentView.addSubViews(titleLabel, genresLabel, releaseLabel)
        footerView.addSubview(faveImageView)
    }
    
    func addConstraints() {
        let horizontalFillConstraints: (LayoutProxy) -> Void = {
            $0.group.left(10).right(-10).fillToSuperView()
        }

        let headerConstraintsBlock: (LayoutProxy) -> Void = {
            $0.group.left.right.top.fillToSuperView()
        }
        
        headerContentView.layout
            .build(block: headerConstraintsBlock)
        
        headerBackgroundView.layout
            .build(block: headerConstraintsBlock)
            .height
            .equal(to: headerContentView.layout.height)
        
        titleLabel.layout
            .build(block: horizontalFillConstraints)
            .top.equalToSuperView(margin: 10)
        
        genresLabel.layout
            .build(block: horizontalFillConstraints)
            .top.equal(to: titleLabel.layout.bottom, offsetBy: 5)
        
        releaseLabel.layout.build(block: horizontalFillConstraints).build {
            $0.top.equal(to: genresLabel.layout.bottom, offsetBy: 5)
            $0.bottom.equalToSuperView(margin: -5)
        }
        movieImageView.layout.build {
            $0.top.equal(to: headerContentView.layout.bottom)
            $0.group.left.right.bottom.fillToSuperView()
        }
        footerView.layout.build {
            $0.group.bottom.left.right.fillToSuperView()
            $0.height.equal(to: 50)
        }
        faveImageView.layout.build {
            $0.group.left(10).centerY.height(.multiply(0.8)).fillToSuperView()
            $0.width.equal(to: $0.height)
        }
        
        movieImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        movieImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        headerBackgroundView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        headerBackgroundView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func applyAditionalChanges() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    private func handleMovieViewModel(_ viewModel: MovieViewModel) {
        viewModel.needReplaceImage = { [weak self] image in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
                self?.headerBackgroundView.image = image
            }
        }
        viewModel.needReplaceGenres = { [weak self] genres in
            DispatchQueue.main.async {
                self?.genresLabel.text = genres
            }
        }

        titleLabel.text = viewModel.movieAtributtes.title
        releaseLabel.text = viewModel.movieAtributtes.release
    }
    
    private func handleFavoritesViewModel(_ viewModel: MovieViewModelWithFavoriteOptions) {
        viewModel.needUpdateFavorite = { [weak self] isFaved in
            DispatchQueue.main.async {
                self?.faveImageView.isFaved = isFaved
            }
        }
    }
}
