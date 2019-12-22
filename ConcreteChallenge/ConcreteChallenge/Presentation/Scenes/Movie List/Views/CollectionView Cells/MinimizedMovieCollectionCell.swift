//
//  MinimizedMovieCollectionCell.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MinimizedMovieCollectionCell: UICollectionViewCell, ViewCodable, MovieViewCell {
    var viewModel: MovieViewModel? {
        didSet {
            let viewModel = self.viewModel!
            
            oldValue?.movieViewWasReused()
            
            viewModel.needReplaceImage = { [weak self] image in
                DispatchQueue.main.async {
                    self?.movieImageView.image = image
                }
            }
            
            titleLabel.text = viewModel.movieAtributtes.title
        }
    }
    
    private let movieImageView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .appRed
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().build {
        $0.textColor = .appTextBlue
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.addSubViews(movieImageView, titleLabel)
    }

    func addConstraints() {
        movieImageView.layout.group
            .top
            .left
            .right.fillToSuperView()
        
        titleLabel.layout.build {
            $0.top.equal(to: movieImageView.layout.bottom)
            $0.group.bottom.left.right.fillToSuperView()
            $0.height.equal(to: 40)
        }
    }
}
