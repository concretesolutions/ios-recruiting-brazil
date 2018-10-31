//
//  UIView+Error.swift
//  Movs
//
//  Created by Maisa on 29/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

final class MovieListErrorView: UIView {
    // MARK: - Properties
    // Error message
    lazy var message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 15.0)
        label.textColor = .darkGray
        return label
    }()
    
    // Image associated the error
    lazy var imageError: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageRatio: CGFloat
    
    // MARK: - Life cycle
    init(frame: CGRect, image: UIImage, message: String) {
        imageRatio = 0.15
        super.init(frame: frame)
        setup(image: image, message: message)
        setupConstraints()
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: - View configuration
    func setup(image: UIImage, message: String) {
        self.message.text = message
        self.imageError.image = image
        addSubview(self.message)
        addSubview(self.imageError)
    }
    
    private func setupConstraints() {
       imageError
            .widthAnchor(equalTo: widthAnchor, multiplier: imageRatio)
            .heightAnchor(equalTo: widthAnchor, multiplier: imageRatio)
            .centerXAnchor(equalTo: centerXAnchor)
            .topAnchor(equalTo: topAnchor, constant: 40)
        
        message
            .topAnchor(equalTo: imageError.bottomAnchor, constant: 15)
            .centerXAnchor(equalTo: centerXAnchor)
            .widthAnchor(equalTo: widthAnchor, multiplier: 0.7)
    }
}
