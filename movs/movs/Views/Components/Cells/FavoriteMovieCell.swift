//
//  FavoriteMovieCell.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var posterImage: UIImageView = {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.textColor = .label
        view.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return view
    }()
    
    lazy var releaseDate: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        view.textColor = .secondaryLabel
        view.textAlignment = .right
        return view
    }()
    
    lazy var synopsis: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 4
        view.lineBreakMode = .byTruncatingTail
        view.textColor = .label
        return view
    }()
    
    // MARK: - Stacks
    lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup cell content
    func setup(with movie: Movie) {
        self.title.text = movie.title
        self.releaseDate.text = movie.releaseDate
        self.synopsis.text = movie.synopsis
        let dataService = DataService.shared
        
        if let posterPath =  movie.posterPath {
            dataService.loadPosterImage(with: posterPath) { (image) in
                movie.posterImage = image
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        } else {
            movie.posterImage = UIImage(named: "PosterUnavailabe")
            self.posterImage.image = movie.posterImage
        }
    }
    
    override func prepareForReuse() {
        self.posterImage.image = nil
        self.title.text = nil
        self.releaseDate.text = nil
        self.synopsis.text = nil
    }
}

extension FavoriteMovieCell: CodeView {
    func buildViewHierarchy() {
        // Title container
        self.titleStack.addArrangedSubview(self.title)
        self.titleStack.addArrangedSubview(self.releaseDate)
        
        // Container view
        self.containerView.addSubview(self.posterImage)
        self.containerView.addSubview(self.titleStack)
        self.containerView.addSubview(self.synopsis)
        
        // View
        self.contentView.addSubview(self.containerView)
    }
    
    func setupConstraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8,
                                                             left: 16,
                                                             bottom: 8,
                                                             right: 16))
        }
        
        self.posterImage.snp.makeConstraints { (make) in
            make.width.equalTo(160*0.8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        self.titleStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(self.posterImage.snp.right).offset(16)
        }
        
        self.synopsis.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleStack.snp.bottom).offset(8).priority(.low)
            make.right.equalTo(self.titleStack.snp.right)
            make.bottom.equalToSuperview().inset(16)
            make.left.equalTo(self.titleStack.snp.left)
            
        }
    }
    
    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .systemBackground
    }
}
