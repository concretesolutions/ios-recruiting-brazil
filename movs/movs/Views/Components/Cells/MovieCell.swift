//
//  MovieCell.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Subviews
    lazy var posterImage: UIImageView = {
        let view = UIImageView(image: nil)
        return view
    }()
    
    lazy var posterGradientLayer: UIImageView = {
       let view = UIImageView(image: UIImage(named: "PosterGradient"))
       return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"),
                                  for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Stacks
    lazy var infoContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 8
        container.alignment = .center
        container.distribution = .fill
        return container
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup cell content
    func setup(with movie: Movie) {
        self.title.text = movie.title
        let dataService = DataService.shared
        if let posterPath =  movie.posterPath {
            dataService.loadPosterImage(withURL: posterPath) { (image) in
                movie.posterImage = image
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.posterImage.image = nil
    }
}

extension MovieCell: CodeView {
    func buildViewHierarchy() {
        // Poster image
        self.posterImage.addSubview(self.posterGradientLayer)
        
        // Info container
        self.infoContainer.addArrangedSubview(self.title)
        self.infoContainer.addArrangedSubview(self.favoriteButton)
        
        // View
        self.contentView.addSubview(self.posterImage)
        self.contentView.addSubview(self.infoContainer)
    }
    
    func setupConstraints() {
        self.posterImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.posterGradientLayer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.infoContainer.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.2)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        self.favoriteButton.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.width.equalTo(40)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
