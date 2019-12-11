//
//  FavoriteMovieTableViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 10/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    // MARK: - Interface Elements
    
    lazy var posterImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    lazy var contentStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16.0
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "The Amazing Return to the La La Land"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "testeeeeeeeeeeeeeeeeeeeeeeeeeee varias linhas espero que tenha tipo umas tres linhas isso aqui tudo que eu to escrevendo pq é bom"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()
    
    // MARK: - Properties
    
    internal var viewModel: MovieViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
            self.summaryLabel.text = self.viewModel.summary
            
            if let posterPath = self.viewModel.posterPath {
                self.posterImage.download(imageURL: "https://image.tmdb.org/t/p/w342\(posterPath)")
            }
        }
    }
    
    // MARK: - Initializers and Deinitializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = .systemGray6
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 8.0
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewCell life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 8.0, bottom: 16.0, right: 8.0))
    }
}

extension FavoriteMovieTableViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentStack.addArrangedSubview(self.titleLabel)
        self.contentStack.addArrangedSubview(self.summaryLabel)

        self.contentView.addSubview(self.posterImage)
        self.contentView.addSubview(self.contentStack)
    }
    
    func setupConstraints() {
        self.posterImage.snp.makeConstraints({ make in
            make.left.top.height.equalTo(self.contentView)
            make.width.equalTo(self.contentView).multipliedBy(0.3)
        })
        
        self.contentStack.snp.makeConstraints({ make in
            make.left.equalTo(self.posterImage.snp.right).offset(16.0)
            make.right.equalTo(self.contentView).inset(16.0)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(self.contentView).multipliedBy(0.7)
        })
    }
}
