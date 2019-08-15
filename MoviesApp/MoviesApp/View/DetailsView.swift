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
    
    lazy var horizonalContainer: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.backgroundColor = .white
        view.spacing = 5
        return view
    }()
    
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        button.imageView?.sizeToFit()
        button.backgroundColor = .red
        return button
    }()
    
    lazy var genresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    lazy var verticalContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
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
    func configure(detailedMovie: SimplifiedMovie,genreNames: String){
        descLabel.text = detailedMovie.description
        genresLabel.text = genreNames
        titleLabel.text = detailedMovie.name
        imageView.image = detailedMovie.bannerImage
    }
}


//MARK: - Extension to define the cell constraints
extension DetailsView: CodeView{
    func buildViewHierarchy() {
        addSubview(imageView)
        horizonalContainer.addSubview(titleLabel)
        horizonalContainer.addSubview(button)
        verticalContainer.addSubview(horizonalContainer)
        verticalContainer.addSubview(genresLabel)
        imageView.addSubview(verticalContainer)
        addSubview(imageView)
        addSubview(descLabel)
    }
    
    func setupConstrains() {
        imageView.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(snp_topMargin)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(genresLabel.snp.top)
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        button.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(genresLabel.snp.top)
            make.left.equalTo(titleLabel.snp.right)
        }
        
        horizonalContainer.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.bottom.equalTo(genresLabel.snp.top)
            make.top.equalToSuperview()
        }
        
        genresLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(horizonalContainer.snp.bottom)
            make.bottom.equalTo(verticalContainer.snp.bottom)
        }
        
        verticalContainer.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(5)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(snp.bottomMargin)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
        
    }
}

