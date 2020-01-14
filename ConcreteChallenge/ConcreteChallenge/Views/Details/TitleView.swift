//
//  TitleView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 11/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class TitleView: UIView {
    let title: String
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = title
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        
//        titleLabel.backgroundColor = .green
        
        return titleLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .white
        
//        lineView.backgroundColor = .yellow
        
        return lineView
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(lineView)
    }
    
    func setupConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -18).isActive = true
        
        lineView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
    }
    
}
