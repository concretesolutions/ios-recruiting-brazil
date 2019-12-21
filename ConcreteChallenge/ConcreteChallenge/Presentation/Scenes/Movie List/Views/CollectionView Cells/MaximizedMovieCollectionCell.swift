//
//  MaximizedMovie.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MaximizedMovieCollectionCell: UICollectionViewCell, ViewCodable, MovieView {
    var viewModel: MovieViewModel? {
        didSet {
            let viewModel = self.viewModel!

            oldValue?.movieViewWasReused()

            viewModel.needReplaceImage = { [weak self] image in
                DispatchQueue.main.async {
                    self?.movieImageView.image = image
                    self?.headerBackgroundView.image = image
                }
            }

            titleLabel.text = viewModel.movieAtributtes.title
        }
    }
    
    let headerBackgroundView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let headerContentView = UIView().build {
        $0.backgroundColor = UIColor.appPurple.withAlphaComponent(0.8)
    }
    
    let movieImageView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel(text: "Title").build {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .appTextPurple
    }
    let genresLabel = UILabel(text: "Genres").build {
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .appTextBlue
    }
    let releaseLabel = UILabel(text: "Release").build {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        addSubViews(headerBackgroundView, headerContentView, movieImageView)
        headerContentView.addSubViews(titleLabel, genresLabel, releaseLabel)
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
        
        movieImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        movieImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        headerBackgroundView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        headerBackgroundView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func applyAditionalChanges() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
