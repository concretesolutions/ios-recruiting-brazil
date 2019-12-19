//
//  ErrorViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 17/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

final class ErrorViewScreen: UIView {
    
    // MARK: - Interface elements
    
    lazy var circleView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: "palettePurple")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 50.0
        return view
    }()
    
    lazy var errorIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "An error ocurred"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var retryButton: ImportantActionButton = {
        let button = ImportantActionButton(frame: .zero)
        button.setTitle("Try again", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.backgroundColor = UIColor.systemGray3
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.systemBackground
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.circleView)
        self.circleView.addSubview(self.errorIcon)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.retryButton)
    }
    
    func setupConstraints() {
        self.circleView.snp.makeConstraints({ make in
            make.width.height.equalTo(100.0)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.9)
        })
        
        self.errorIcon.snp.makeConstraints({ make in
            make.width.equalTo(self.circleView).multipliedBy(0.7)
            make.centerX.centerY.equalTo(self.circleView)
            make.height.equalTo(self.errorIcon.snp.width).multipliedBy(0.802)
        })
        
        self.titleLabel.snp.makeConstraints({ make in
            make.centerX.equalTo(self.circleView)
            make.top.equalTo(self.circleView.snp.bottom).offset(24.0)
        })
        
        self.descriptionLabel.snp.makeConstraints({ make in
            make.centerX.equalTo(self.circleView)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            make.leading.equalTo(self).offset(40.0)
            make.trailing.equalTo(self).inset(40.0)
        })
        
        self.retryButton.snp.makeConstraints({ make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(32.0)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.45)
            make.height.equalTo(self.retryButton.snp.width).multipliedBy(0.33)
        })
    }
}
