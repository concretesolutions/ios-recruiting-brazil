//
//  MovieBoxView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieBoxView: UIView {
    
    lazy var movieImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Title"
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        view.textColor = UIColor.Movs.yellow
        view.textAlignment = .center
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "FavoriteGrayIcon"), for: .normal)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension MovieBoxView: CodeView {
    
    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(title)
        addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        movieImage.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.75)
            make.top.equalTo(movieImage.snp.bottom)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.left.equalTo(title.snp.right)
            make.top.equalTo(movieImage.snp.bottom)
        }
        
        favoriteButton.imageView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(25)
        })
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.Movs.gray
    }
    
}
