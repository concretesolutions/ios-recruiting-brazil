//
//  FavoriteMoviesTableViewCell.swift
//  Movs
//
//  Created by Erick Lozano Borges on 20/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Reusable

class FavoriteMoviesTableViewCell: UITableViewCell, Reusable {
    
    //MARK: - Properties
    // Data
    var movie: Movie!
    
    //MARK: - Interface
    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = Design.colors.dark
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseYearLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = Design.colors.dark
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Design.colors.dark.withAlphaComponent(0.9)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Setup
    func setup(_ movie: Movie) {
        self.movie = movie
        selectionStyle = .none
        setupView()
    }
       
}

//MARK: - CodeView
extension FavoriteMoviesTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseYearLabel)
        contentView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().priority(.high)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(1).priority(.high)
        }
        
        thumbnail.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(thumbnail.snp.height).multipliedBy(2.0/3.0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbnail.snp.right).offset(10)
            make.top.equalToSuperview().offset(10).priority(.high)
            make.height.equalTo("9999".height(withConstrainedWidth: 100, font: titleLabel.font)).priority(.high)
        }
        releaseYearLabel.snp.makeConstraints { (make) in
            let labelHeight = "9999".height(withConstrainedWidth: 100, font: releaseYearLabel.font)
            let labelWidth = "9999".width(withConstrainedHeight: labelHeight, font: releaseYearLabel.font)
            
            make.left.equalTo(titleLabel.snp.right)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(labelHeight).priority(.high)
            make.width.equalTo(labelWidth)
        }
        overviewLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbnail.snp.right).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10).priority(.high)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10).priority(.high)
        }

    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = Design.colors.lightGray
        thumbnail.image = movie.thumbnail
        titleLabel.text = movie.title
        releaseYearLabel.text = movie.releaseYear
        overviewLabel.text = movie.overview
    }

}
