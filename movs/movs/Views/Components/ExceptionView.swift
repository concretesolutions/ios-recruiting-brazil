//
//  ExceptionView.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class ExceptionView: UIView {
    // MARK: - Subviews
    lazy var image: UIImageView = {
        let view = UIImageView(image: nil)
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, imageNamed: String, title: String) {
        super.init(frame: frame)
        self.image.image = UIImage(named: imageNamed)
        self.title.text = title
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExceptionView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.image)
        self.addSubview(self.title)
    }
    
    func setupConstraints() {
        self.image.snp.makeConstraints { (make) in
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1)
        }
        
        self.title.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.image.snp.bottom).offset(16)
        }
    }
}
