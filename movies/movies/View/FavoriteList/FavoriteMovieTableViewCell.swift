//
//  FavoriteMovieTableViewCell.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    private var viewModel: FavoriteMovieCellViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
            self.dateLabel.text = self.viewModel.date
            self.overviewLabel.text = self.viewModel.overview
            self.posterImageView.setImage(withURL: self.viewModel.posterURL)
        }
    }
    
    let posterImageView = PosterImageView()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Title"
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.textColor = .secondaryLabel
        view.textAlignment = .right
        return view
    }()
    
    lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 3
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ viewModel: FavoriteMovieCellViewModel) {
        self.viewModel = viewModel
    }
}

extension FavoriteMovieTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(posterImageView)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(1/1.5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(posterImageView.snp.right).offset(10)
            make.right.equalTo(dateLabel.snp.left).inset(10)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(posterImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
