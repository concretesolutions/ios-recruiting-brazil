//
//  FavoriteMovieTableViewCell.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    public var viewModel: FavoriteMovieCellViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
            self.dateLabel.text = self.viewModel.date
            self.overviewLabel.text = self.viewModel.overview
//            downloadPoster()
        }
    }
    
    lazy var posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
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
        return view
    }()
    
    lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 3
        return view
    }()
    
    convenience init(with viewModel: FavoriteMovieCellViewModel) {
        self.init(frame: .zero)
        
        defer {
            self.viewModel = viewModel
        }
        
        setupView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupView()
    }
    
    private func downloadPoster() {
        URLSession.shared.dataTask(with: self.viewModel.posterURL) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }.resume()
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
            make.top.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(1/1.5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(posterImageView.snp.right).offset(10)
            make.right.equalTo(dateLabel.snp.left).inset(10)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(posterImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
