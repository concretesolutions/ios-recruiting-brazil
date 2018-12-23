//
//  FavoriteMovieTableViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 23/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class FavoriteMovieTableViewCell: UITableViewCell, Reusable {

    var movie: Movie!
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var releasedYearLabel:UILabel = {
        let releasedYearLabel = UILabel(frame: .zero)
        releasedYearLabel.translatesAutoresizingMaskIntoConstraints = false
        return releasedYearLabel
    }()
    
    lazy var overviewLabel:UILabel = {
        let overviewLabel = UILabel(frame: .zero)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        return overviewLabel
    }()
    
    func setup(movie: Movie){
        self.movie = movie
        setupView()
        //FIXME: verify if image comes right
    }
    
}

extension FavoriteMovieTableViewCell: CodeView{
    func buildViewHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releasedYearLabel)
        contentView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        //FIXME:- change constraints if needed
        posterImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalTo(releasedYearLabel.snp.leading)
        }
        
        releasedYearLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(titleLabel.snp.trailing)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.bottom.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        posterImageView.image = self.movie.poster
        titleLabel.text = self.movie.title
        releasedYearLabel.text = self.movie.releaseYear
        overviewLabel.text = self.movie.overview
        overviewLabel.numberOfLines = 0
    }
    
    
}
