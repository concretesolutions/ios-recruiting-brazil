//
//  ErrorView.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 27/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
/**
Error Feedback View
 */
class ErrorView: UIView {
    
    var errorImageName: String
    var errorText: String
    
    var errorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var errorTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 27)
        return label
    }()
    
    init(errorImageName: String, errorText: String) {
        self.errorImageName = errorImageName
        self.errorText = errorText
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .red
        self.errorTitle.text = errorText
        self.errorImage.image = UIImage(named: errorImageName)
        self.addSubview(errorImage)
        self.addSubview(errorTitle)
    }
    
    func setupConstraints() {
    
        errorImage.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: 40).isActive = true
        errorImage.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 100).isActive = true
        errorImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        errorImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        errorTitle.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: 20).isActive = true
        errorTitle.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
        errorTitle.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
