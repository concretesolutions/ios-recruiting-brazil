//
//  ErrorView.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

final class ErrorView: UIView, CodeView {
    lazy var xLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont(name: "helvetica", size: CGFloat(180))
        label.text = "×"
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(displayingMessage message: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.textLabel.text = message
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        self.addSubview(xLabel)
        self.addSubview(textLabel)
    }
    
    func setupConstraints() {
        xLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        xLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        xLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        xLabel.bottomAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.textLabel.sizeToFit()
    }
}
