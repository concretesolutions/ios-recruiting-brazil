//
//  MaximizedMovie.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MaximizedMovieCollectionCell: UICollectionViewCell, ViewCodable {
    let headerLayoutGuide = UILayoutGuide()
    
    let headerBackgroundView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
    }
    
    let headerContentView = UIView().build {
        $0.backgroundColor = UIColor.appPurple.withAlphaComponent(0.7)
    }
    
    let movieImageView = UIImageView()
    
    let titleLabel = UILabel().build {
        $0.text = "Title"
    }
    let genresLabel = UILabel().build {
        $0.text = "genres"
    }
    let releaseLabel = UILabel().build {
        $0.text = "release"
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
        addLayoutGuide(headerLayoutGuide)
    }
    
    func addConstraints() {
        let horizontalFillConstraints: (LayoutProxy) -> Void = {
            $0.group.left.right.fillToSuperView()
        }

        let headerConstraintsBlock: (LayoutProxy) -> Void = {
            $0.build(block: horizontalFillConstraints)
            $0.top.equalToSuperView()
        }
        
        headerContentView.layout
            .build(block: headerConstraintsBlock)
        
        headerBackgroundView.layout
            .build(block: headerConstraintsBlock)
            .height
            .equal(to: headerContentView.layout.height)
        
        titleLabel.layout.group.top.left.right.fillToSuperView()
        genresLabel.layout
            .build(block: horizontalFillConstraints)
            .top
            .equal(to: titleLabel.layout.bottom)
        
        releaseLabel.layout.build(block: horizontalFillConstraints).build {
            $0.top.equal(to: genresLabel.layout.bottom)
            $0.bottom.equalToSuperView()
        }
        
        movieImageView.layout.build(block: horizontalFillConstraints).build {
            $0.top.equal(to: headerContentView.layout.bottom)
            $0.bottom.equalToSuperView()
        }
        
        movieImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        movieImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
