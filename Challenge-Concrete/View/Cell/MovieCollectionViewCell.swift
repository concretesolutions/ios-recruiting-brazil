//
//  MovieCollectionViewCell.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit
import SmartConstraint

class MovieCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let title = UILabel()
    
    static var lineSpacing: CGFloat = 16
    
    static func size(for parentWidth: CGFloat) -> CGSize {
        let orientation = UIDevice.current.orientation
        let orientationIsLeftOrRight = orientation == .landscapeLeft || orientation == .landscapeRight
        let numberOfCells: CGFloat = orientationIsLeftOrRight ? 3 : 2
        let width = (parentWidth / numberOfCells) - (lineSpacing/2)
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
    
    func setupData() {
        imageView.image = UIImage()
        imageView.backgroundColor = .blue
        title.text = "Teste"
        setupView()
    }
    
    
}

extension MovieCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubviews([imageView])
    }
    
    func buildConstraints() {
        imageView.anchor.attatch(to: safeAreaLayoutGuide)
    }
}
