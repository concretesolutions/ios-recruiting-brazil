//
//  MovieCollectionViewCell.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import SnapKit
class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var safeArea = self.layoutMarginsGuide
    
    lazy var activityIndicatorToImage:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    lazy var viewCell: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let view = UIButton(type: .custom) as UIButton
        let icon = UIImage(named: "iconStarFill")
        view.setImage(icon, for: .normal)
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    lazy var titleCover: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var movieTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = UIColor(named: "whiteCustom")
        return view
    }()
    
    override func layoutSubviews() {
        self.movieTitle.numberOfLines = 0
        self.movieImageView.layer.masksToBounds = true
        self.movieImageView.clipsToBounds = true
//        self.movieImageView.layer.cornerRadius = 8
//        self.viewCell.layer.cornerRadius = 8
        self.movieTitle.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.addSubview(viewCell)
        self.viewCell.addSubview(movieImageView)
        self.movieImageView.addSubview(favoriteButton)
        self.movieImageView.addSubview(activityIndicatorToImage)
        self.movieImageView.addSubview(titleCover)
        self.titleCover.addSubview(movieTitle)
        self.movieTitle.textAlignment = .center
        self.favoriteButton.isHidden = true
        viewCell.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        movieImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(viewCell)
        }
        
        activityIndicatorToImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        titleCover.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(viewCell.snp.height).multipliedBy(0.23)
        }
        
        movieTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
