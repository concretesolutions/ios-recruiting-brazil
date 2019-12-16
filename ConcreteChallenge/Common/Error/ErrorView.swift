//
//  ErrorView.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ErrorView: UIView {
    
    // MARK: - Properties -
    let imageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "error"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Error: something went wrong.\nPlease try again."
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -
    // MARK: View
    func setup() {
        
        self.backgroundColor = .white
        
        self.addSubview(imageView)
        self.addSubview(label)
        
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.equalTo(self.snp.centerY).priority(999)
        }
        
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
    
    func displayMessage(_ messageType: ErrorMessageType) {
        
        switch messageType {
        case .generic:
            label.text = "Error: something went wrong.\nPlease try again."
            imageView.image = #imageLiteral(resourceName: "error")
        case .missing(let message):
            label.text = message
            imageView.image = #imageLiteral(resourceName: "none")
        case .info(let message):
            label.text = message
            imageView.image = #imageLiteral(resourceName: "error")
        }
    }
}

// Kingfisher needs this to work as a placeholder
extension ErrorView: Placeholder { }
