//
//  ErrorView.swift
//  movies
//
//  Created by Jacqueline Alves on 09/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

final class ErrorView: UIView {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .title2)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect = .zero, imageName: String, text: String) {
        self.init(frame: frame)
        
        self.imageView.image = UIImage(named: imageName)
        self.label.text = text
    }
    
    func setText(_ text: String) {
        self.label.text = text
    }
}

extension ErrorView: CodeView {
    
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(label)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
