//
//  FavoritesCustomCell.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class FavoritesCustomCell: UITableViewCell {
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 5
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - Object Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Helpers
    func setData(data: Favorites.ViewModel.movie) {
        self.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + data.imageUrl)) { (image, _, _, _) in
            if image == nil {
                DispatchQueue.main.async {
                    self.movieImage.image = #imageLiteral(resourceName: "placeholder")
                }
            }
        }
        self.titleLabel.text = data.title
        self.yearLabel.text = data.releaseYear
        self.overviewLabel.text = data.overview
    }
}

extension FavoritesCustomCell: CodeView {
    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        self.movieImage.snp.makeConstraints { (maker) in
            maker.height.equalTo(self)
            maker.width.equalTo(self.frame.width * 0.30)
            maker.left.equalTo(self)
            maker.centerY.equalTo(self)
        }
        self.titleLabel.snp.makeConstraints { (maker) in
            maker.top.lessThanOrEqualTo(self).offset(10)
            maker.left.lessThanOrEqualTo(self.movieImage.snp.right).offset(10)
            maker.width.equalTo(200)
        }
        self.yearLabel.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right).inset(10)
            maker.centerY.equalTo(self.titleLabel)
            maker.left.equalTo(self.titleLabel.snp.right)
        }
        self.overviewLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.yearLabel.snp.bottom)
            maker.left.equalTo(self.movieImage.snp.right).offset(10)
            maker.right.equalTo(self).inset(10)
            maker.bottom.equalTo(self)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .black
        self.selectionStyle = .none
    }
    
}
