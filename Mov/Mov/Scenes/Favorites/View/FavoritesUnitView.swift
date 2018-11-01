//
//  FavoritesUnitView.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class FavoritesUnitView: UIView {
    
    var viewModel = FavoritesViewModel.placeHolder {
        didSet {
            self.titleLabel.text = self.viewModel.title
            self.viewModel.fetchImage(to: self.poster)
            self.yearLabel.text = self.viewModel.year
            self.overviewLabel.text = self.viewModel.overview
        }
    }
    
    // UI Elements
    lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.text = viewModel.title
        title.numberOfLines = 2
        title.lineBreakMode = .byTruncatingTail
        title.font = UIFont(name: Fonts.helveticaNeueBold, size: CGFloat(18).proportionalToWidth)
        title.textAlignment = .left
        
        return title
    }()
    
    lazy var yearLabel: UILabel = {
        let year = UILabel(frame: .zero)
        year.text = self.viewModel.year
        year.font = UIFont(name: Fonts.helveticaNeue, size: CGFloat(18).proportionalToWidth)
        year.textAlignment = .right
        
        return year
    }()
    
    lazy var overviewLabel: UILabel = {
        let overview = UILabel(frame: .zero)
        overview.text = self.viewModel.overview
        overview.numberOfLines = 4
        overview.lineBreakMode = .byTruncatingTail
        overview.font = UIFont(name: Fonts.helveticaNeue, size: CGFloat(16).proportionalToWidth)
        
        return overview
    }()
    
    lazy var titleYearStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        stack.addArrangedSubview(self.titleLabel)
        stack.addArrangedSubview(self.yearLabel)
        
        return stack
    }()
    
    lazy var overviewStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = CGFloat(5).proportionalToHeight
        
        stack.addArrangedSubview(self.titleYearStack)
        stack.addArrangedSubview(self.overviewLabel)
        
        return stack
    }()
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        self.viewModel.fetchImage(to: imageView)
        
        return imageView
        
    }()
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesUnitView: ViewCode {
    
    public func addView() {
        self.addSubview(self.poster)
        self.addSubview(self.overviewStack)

    }
    
    public func addConstraints() {
        self.poster.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
//            make.height.equalToSuperview()
        }
        
        self.overviewStack.snp.makeConstraints { make in
            make.right.equalToSuperview().multipliedBy(0.95)
            make.left.equalTo(self.poster.snp.right).multipliedBy(1.2)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.centerY.equalToSuperview()
        }
    }
    
}

