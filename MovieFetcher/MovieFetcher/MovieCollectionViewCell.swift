//
//  MovieCollectionViewCell.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var safeArea:UILayoutGuide!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        safeArea = layoutMarginsGuide
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    func setContraints(){
        poster.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        poster.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        poster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        poster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func setUp(image:UIImage){
        
        self.poster.layer.masksToBounds = true
        self.poster.image = image
      
    }
    
}
