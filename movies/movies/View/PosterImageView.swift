//
//  PosterImageView.swift
//  movies
//
//  Created by Jacqueline Alves on 09/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class PosterImageView: UIImageView {
    let cornerRadius: CGFloat = 12
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = self.cornerRadius
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(withURL url: URL) {
        self.imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder_poster"), options: [.transition(.fade(0.3))])
    }
}

extension PosterImageView: CodeView {
    func buildViewHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = self.cornerRadius
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.label.cgColor
        self.layer.shadowOpacity = 0.5
    }
}
