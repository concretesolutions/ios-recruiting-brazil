//
//  MinimizedMovieCollectionCell.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MinimizedMovieCollectionCell: UICollectionViewCell, ViewCodable {
    let movieImageView = UIImageView().build {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
    }
    
    let movieLabel = UILabel().build {
        $0.backgroundColor = .blue
        $0.text = "bla"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.addSubViews(movieImageView, movieLabel)
    }

    func addConstraints() {
        movieImageView.layout.group
            .top
            .left
            .right.fillToSuperView()
        
        movieLabel.layout.build {
            $0.top.equal(to: movieImageView.layout.bottom)
            $0.group.bottom.left.right.fillToSuperView()
        }
    }
}
