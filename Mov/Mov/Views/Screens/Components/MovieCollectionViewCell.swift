//
//  MovieCollectionViewCell.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "thor6")
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor(red:0.97, green:0.71, blue:0.17, alpha:1.00)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
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


extension MovieCollectionViewCell: CodeView{
    func buidViewHirarchy() {
        
        addSubview(imageView)
        addSubview(title)
        addSubview(favoriteButton)
        
    }
    
    func setupContraints() {
        
        imageView.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.8)
            make.height.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().multipliedBy(1.8)
            make.centerY.equalToSuperview().multipliedBy(1.8)
            make.height.equalTo(18)
            make.width.equalTo(18)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
    }
    
    
}



