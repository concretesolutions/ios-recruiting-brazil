//
//  MovieDetailView.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 15/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    let scrollView = UIScrollView()
    let movieImageView = UIImageView()
    let title = UILabel()
    let favoriteButton = UIButton(type: .infoDark)
    let year = UILabel()
    let genders = UILabel()
    let overview = UILabel()
    
    override func didMoveToSuperview() {
        setupView()
    }
}

extension MovieDetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubviews([movieImageView, title, favoriteButton,
                                year, genders, overview])
    }
    
    func buildConstraints() {
        scrollView.anchor.attatch(to: safeAreaLayoutGuide)
        
        let imgWidth: CGFloat = 250
        let imgHeight: CGFloat = imgWidth * 1.3
        movieImageView.anchor
            .top(scrollView.topAnchor, padding: 16)
            .centerX(scrollView.centerXAnchor)
            .width(constant: imgWidth)
            .height(constant: imgHeight)
        
        title.anchor
            .top(movieImageView.bottomAnchor, padding: 16)
            .left(scrollView.leftAnchor, padding: 16)
            .right(favoriteButton.leftAnchor, padding: 16)
        
        favoriteButton.anchor
            .top(movieImageView.bottomAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .width(constant: 20)
            .height(constant: 20)
        
        year.anchor
            .top(title.bottomAnchor, padding: 16)
            .left(scrollView.leftAnchor, padding: 16)
            .right(scrollView.rightAnchor, padding: 16)
        
        genders.anchor
            .top(year.bottomAnchor, padding: 16)
            .left(scrollView.leftAnchor, padding: 16)
            .right(scrollView.rightAnchor, padding: 16)
        
        overview.anchor
            .top(genders.bottomAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .bottom(scrollView.bottomAnchor, padding: 16)
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
        movieImageView.backgroundColor = .red
        title.text = "Thor 2412412412412 123123123123123231"
        year.text = "2008"
        genders.text = "Action, Adventure"
        overview.numberOfLines = 0
        overview.text = "The powerful, put arrogant god Thor. The powerful, put arrogant god Thor. The powerful, put arrogant god Thor. The powerful, put arrogant god Thor. The powerful, put arrogant god Thor."
    }
}
