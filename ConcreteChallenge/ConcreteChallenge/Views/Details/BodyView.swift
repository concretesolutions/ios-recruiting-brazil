//
//  BodyView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 14/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class BodyView: UIView {
    
    let text: String
    
    lazy var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.text = text
        bodyLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        bodyLabel.textColor = .white
        bodyLabel.numberOfLines = 0
        
        return bodyLabel
    }()
    
    init(text: String) {
        self.text = text
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(bodyLabel)
    }
    
    func setupConstraints() {
        bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
