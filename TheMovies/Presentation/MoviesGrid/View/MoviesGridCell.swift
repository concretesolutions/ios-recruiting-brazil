//
//  MoviesGridCell.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/25/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

final class MoviesGridCell: UICollectionViewCell {

    //MARK:- Views -
    private(set) var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.clipsToBounds = true
        return image
    }()
    
    private(set) var label: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.textAlignment = .center
        
        return label
    }()
    
    private(set) var favorite: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "favorite_gray_icon")

        return view
    }()
    
    private(set) var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) var gradient: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    
    var id: Int = 0
    
    //MARK:- Constructors -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    fileprivate func setupUIElements() {
        // arrange subviews
        backgroundColor = .clear
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.2
        
        self.addSubview(container)
        self.container.addSubview(image)
        self.container.addSubview(label)
        self.container.addSubview(favorite)
    }
    
    fileprivate func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        container.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.left.right.bottom.equalTo(guide)
        }
        
        image.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(container)
            ConstraintMaker.height.equalTo(container).multipliedBy(0.8)
            ConstraintMaker.width.equalTo(container)
        }
        
        label.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(image)
            ConstraintMaker.width.equalTo(image).multipliedBy(0.6)
            ConstraintMaker.top.equalTo(image.snp.bottom).offset(5)
            ConstraintMaker.bottom.equalTo(container).inset(5)
        }
        
        favorite.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.right.equalTo(container).inset(5)
            ConstraintMaker.width.height.equalTo(label.snp.height).multipliedBy(0.6)
            ConstraintMaker.centerY.equalTo(label)
        }
    }
}
