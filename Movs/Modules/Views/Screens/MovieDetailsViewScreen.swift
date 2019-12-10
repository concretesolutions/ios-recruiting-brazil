//
//  MovieDetailsViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

final class MovieDetailsViewScreen: UIView {
    
    // MARK: - Interface elements
    
    lazy var backdrop: UIImageView = {
        let backdrop = UIImageView(frame: .zero)
        backdrop.backgroundColor = UIColor.secondarySystemBackground
        backdrop.contentMode = .scaleAspectFill
        return backdrop
    }()
    
    lazy var overlay: UIView = {
        let overlay = UIView(frame: .zero)
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.5
        return overlay
    }()
    
    lazy var favoriteButton: FavoriteButton = {
        let button = FavoriteButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 26.0, weight: .bold)
        title.numberOfLines = 0
        title.textColor = UIColor.white
        return title
    }()
    
    lazy var releaseYearLabel: SectionHeadingLabel = {
        return SectionHeadingLabel()
    }()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailsViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.backdrop)
        self.addSubview(self.overlay)
        self.addSubview(self.favoriteButton)
        self.addSubview(self.titleLabel)
    }
    
    func setupConstraints() {
        self.backdrop.snp.makeConstraints({ make in
            make.top.centerX.width.equalTo(self)
            make.height.equalTo(self.backdrop.snp.width).multipliedBy(0.65)
        })
        
        self.overlay.snp.makeConstraints({ make in
            make.width.height.centerX.centerY.equalTo(self.backdrop)
        })
        
        self.favoriteButton.snp.makeConstraints({ make in
            make.trailing.equalTo(self.backdrop).inset(24.0)
            make.bottom.equalTo(self.backdrop).inset(16.0)
            make.width.height.equalTo(32.0)
        })
        
        self.titleLabel.snp.makeConstraints({ make in
            make.leading.equalTo(self.backdrop).inset(24.0)
            make.bottom.equalTo(self.backdrop).inset(16.0)
            make.trailing.lessThanOrEqualTo(self.favoriteButton).offset(-24.0)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.systemBackground
    }
}
