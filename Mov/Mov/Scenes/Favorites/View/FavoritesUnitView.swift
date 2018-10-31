//
//  FavoritesUnitView.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class FavoritesUnitView: UIView {
    
    // UI Elements
    lazy var titleLabel: UILabel = {
        
        return UILabel(frame: .zero)
    }()
    
    lazy var yearLabel: UILabel = {
        
        return UILabel(frame: .zero)
    }()
    
    lazy var titleYearStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = CGFloat(20).proportionalToWidth
        stack.addArrangedSubview(self.titleLabel)
        stack.addArrangedSubview(self.yearLabel)
        
        return stack
    }()
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView(image: Images.poster_placeholder)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }()
    
    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesUnitView: ViewCode {
    
    public func addView() {
        self.addSubview(self.titleYearStack)
        self.addSubview(self.titleYearStack)
    }
    
    public func addConstraints() {
        self.poster.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        self.titleYearStack.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalTo(self.poster.snp_rightMargin)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
    }
    
}

