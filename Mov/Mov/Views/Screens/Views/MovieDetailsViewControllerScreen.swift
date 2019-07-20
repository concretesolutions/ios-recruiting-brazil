//
//  MovieDetailsViewControllerScreen.swift
//  Mov
//
//  Created by Victor Leal on 19/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit
import SnapKit

final class MovieDetailsViewControllerScreen: UIView {
    
    let movieImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = #imageLiteral(resourceName: "thor6")
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .black
        view.textAlignment = .left
        view.text = "title"
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        return view
    }()
    
    let year: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .black
        view.textAlignment = .left
        view.text = "2001"
        return view
    }()
    
    let genre: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .black
        view.textAlignment = .left
        view.text = "Ação"
        return view
    }()
    
    let movieDescription: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.text = "init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented"
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension MovieDetailsViewControllerScreen: CodeView{
    func buidViewHirarchy() {
        addSubview(movieImage)
        addSubview(title)
        addSubview(favoriteButton)
        addSubview(year)
        addSubview(genre)
        addSubview(movieDescription)
    }
    
    func setupContraints() {
        
        movieImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(75)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(movieImage.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(14)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(movieImage.snp.bottom).offset(14)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        year.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(14)
        }
        
        genre.snp.makeConstraints { (make) in
            make.top.equalTo(year.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(14)
        }
        
        movieDescription.snp.makeConstraints { (make) in
            make.top.equalTo(genre.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(60)
        }
        
        
        
        
        
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
    }
    
    
}

