//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - The view basic configuration and visual elements
class DetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.sizeToFit()
        return view
    }()
    
    lazy var favButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = UsedColor.blue.color
        view.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        view.setImage(UIImage(named: "favorite_full_icon"), for: .selected)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = UsedColor.yellow.color
        view.numberOfLines = 0
        return view
    }()
    
    lazy var genresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = UsedColor.yellow.color
        view.numberOfLines = 0
        return view
    }()
    
    lazy var verticalContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UsedColor.blue.color
        return view
    }()
    
    lazy var descLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 0
        return view
    }()
    
}

//MARK: - Extension to define the cell constraints
extension DetailsView{
    func configure(detailedMovie: PresentableMovieInterface,genreNames: String,isFavorite: Bool){
        descLabel.text = detailedMovie.description
        genresLabel.text = genreNames
        titleLabel.text = detailedMovie.name
        imageView.image = detailedMovie.bannerImage
        
        favButton.isSelected = isFavorite
    }
}


//MARK: - Extension to define the cell constraints
extension DetailsView: CodeView{
    func buildViewHierarchy() {
        verticalContainer.addSubview(titleLabel)
        verticalContainer.addSubview(genresLabel)
        imageView.addSubview(verticalContainer)
        bringSubviewToFront(favButton)
        addSubview(imageView)
        addSubview(descLabel)
        addSubview(favButton)
    }
    
    func setupConstrains() {
        imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(snp_topMargin).offset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview().offset(2)
        }
        
        genresLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(verticalContainer.snp.bottom)
        }
        
        verticalContainer.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.left.equalToSuperview()
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        favButton.snp.makeConstraints { (make) in
            make.left.equalTo(verticalContainer.snp.right)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.125)
        }
        
        
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(5)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(snp.bottomMargin)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

