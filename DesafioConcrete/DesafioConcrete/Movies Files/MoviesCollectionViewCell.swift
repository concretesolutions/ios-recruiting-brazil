//
//  MoviesCollectionViewCell.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "moviesCollectionViewCell"
    
    var image:UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    var favButton:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"favorite_gray_icon"), for: .normal)
        btn.contentMode = .scaleToFill
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        
        let viewWidth = self.contentView.frame.width
        let viewHeight = self.contentView.frame.height
        
        contentView.addSubview(image)
        image.addSubview(favButton)
        
        contentView.backgroundColor = .gray
        
        contentView.setUpContraint(pattern: "H:|[v0(\(viewWidth))]", views: image)
        contentView.setUpContraint(pattern: "V:|[v0(\(viewHeight))]", views: image)
        
        image.setUpContraint(pattern: "H:[v0(\(60))]|", views: favButton)
        image.setUpContraint(pattern: "V:[v0(\(60))]|", views: favButton)
        
    }
}
