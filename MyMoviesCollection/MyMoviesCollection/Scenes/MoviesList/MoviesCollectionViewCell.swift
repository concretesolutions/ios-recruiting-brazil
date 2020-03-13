//
//  MoviesCollectionViewCell.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private lazy var bannerView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infosView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(red: 45.0 / 255.0, green: 48.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    func addViews(){
        backgroundColor = .lightGray
        contentView.addSubview(bannerView)
        contentView.addSubview(infosView)
        infosView.addSubview(titleText)
        infosView.addSubview(favoriteButton)
        
        bannerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60).isActive = true
        
        infosView.topAnchor.constraint(equalTo: bannerView.bottomAnchor).isActive = true
        infosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        infosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        infosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleText.topAnchor.constraint(equalTo: infosView.topAnchor, constant: 5).isActive = true
        titleText.leadingAnchor.constraint(equalTo: infosView.leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: infosView.trailingAnchor, constant: -30).isActive = true
        titleText.bottomAnchor.constraint(equalTo: infosView.bottomAnchor, constant: -5).isActive = true
        
        favoriteButton.centerYAnchor.constraint(equalTo: infosView.centerYAnchor).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
