//
//  MovieCell.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    private var viewModel: PopularMoviesCellViewModelType!
    
    private lazy var img: UIImageView = {
        let img = UIImageView(frame: .zero)
//        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var lbMovieName: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .lightYellow
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var btFavorite: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        button.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        return button
    }()
    
    @objc func favoriteAction() {
        print("favorite")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(viewModel: PopularMoviesCellViewModelType) {
        self.viewModel = viewModel
        self.lbMovieName.text = viewModel.title
        self.img.loadImage(url: viewModel.imgUrl)
        self.contentView.backgroundColor = .darkBlue
    }
}

extension MovieCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.img)
        self.contentView.addSubview(self.lbMovieName)
        self.contentView.addSubview(self.btFavorite)
    }
    
    func setupConstraints() {
        self.img.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
        self.lbMovieName.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.img.snp_bottomMargin)
        }
        
        self.btFavorite.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.width.equalTo(40)
            make.top.equalTo(self.img.snp_bottomMargin)
        }
    }
}
