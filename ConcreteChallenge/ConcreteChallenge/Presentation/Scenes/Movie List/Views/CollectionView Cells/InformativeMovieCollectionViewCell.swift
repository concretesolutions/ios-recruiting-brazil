//
//  InformativeMovieCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class InformativeMovieCollectionViewCell: UICollectionViewCell, ViewCodable, MovieViewCell {
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
            overviewLabel.text = viewModel.movieAtributtes.description
            releaseDateLabel.text = viewModel.movieAtributtes.release
        }
    }
    
    private let contentMarginsGuide = UILayoutGuide()
    
    private let movieImageView = UIImageView().build {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .appRed
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().build {
        $0.text = "title"
        $0.textColor = .appTextBlue
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let overviewLabel = UILabel().build {
        $0.text = "overview"
        $0.textColor = .appTextPurple
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 0
    }
    
    private let releaseDateLabel = UILabel().build {
        $0.text = "date"
        $0.textColor = .appTextPurple
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.addSubViews(movieImageView, titleLabel, releaseDateLabel, overviewLabel)
        addLayoutGuide(contentMarginsGuide)
    }

    func addConstraints() {
        movieImageView.layout.build {
            $0.group.top.left.bottom.fillToSuperView()
            $0.width.equal(to: $0.height, multiplier: 0.7)
        }
        
        contentMarginsGuide.layout.build {
            $0.group.top(10)
                    .bottom(-10)
                    .right(-10)
                    .fill(to: self)
            $0.left.equal(to: movieImageView.layout.right, offsetBy: 10)
        }
        
        titleLabel.layout.build {
            $0.group.top.left.right.fill(to: contentMarginsGuide)
            $0.height.equal(to: 20)
        }
        
        releaseDateLabel.layout.build {
            $0.top.equal(to: titleLabel.layout.bottom, offsetBy: 10)
            $0.group.left.right.fill(to: contentMarginsGuide)
            $0.height.equal(to: 15)
        }
        
        overviewLabel.layout.build {
            $0.top.equal(to: releaseDateLabel.layout.bottom, offsetBy: 10)
            $0.group.left.bottom.right.fill(to: contentMarginsGuide)
        }
    }
}
