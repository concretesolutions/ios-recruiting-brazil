//
//  MovieGridUnit.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit
import SnapKit

class MovieGridUnitView: UIView {
    
    var viewModel: MovieGridViewModel = .placeHolder {
        didSet {
            self.viewModel.fetchImage(to: self.poster)
            self.title.text = self.viewModel.title
            self.favoriteButton.setImage(self.viewModel.isFavoriteIcon, for: .normal)
        }
    }
    
    @objc var favoriteButtonAction: ((UIButton) -> Void)?
    
    // UI Elements
    lazy var poster: UIImageView = {
        let poster = UIImageView(frame: .zero)
        self.viewModel.fetchImage(to: poster)
        self.contentMode = .scaleAspectFit
        return poster
    }()
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.text = self.viewModel.title
        title.textAlignment = .center
        title.textColor = Colors.lightYellow
        title.font = UIFont(name: Fonts.helveticaNeue, size: CGFloat(16).proportionalToHeight)
        
        return title
    }()
    
    lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton(frame: .zero)
        favoriteButton.setImage(self.viewModel.isFavoriteIcon, for: .normal)
        favoriteButton.imageView!.contentMode = .scaleAspectFill
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        
        return favoriteButton
    }()
    
    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapFavoriteButton(_ sender: UIButton) {
        if let action = self.favoriteButtonAction {
            action(sender)
        } else {/*do nothing*/}
    }
}

extension MovieGridUnitView: ViewCode {
    
    public func addView() {
        self.addSubview(self.poster)
        self.addSubview(self.title)
        self.addSubview(self.favoriteButton)
    }
    
    public func addConstraints() {
        self.poster.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        self.title.snp.makeConstraints { make in
            make.top.equalTo(self.poster.snp_bottomMargin)
            make.bottom.equalToSuperview()
            make.right.equalTo(self.favoriteButton.snp_leftMargin)
            make.centerX.equalToSuperview()
        }
        
        self.favoriteButton.snp.makeConstraints { make in
            make.height.equalTo(self.title)
            make.centerY.equalTo(self.title)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func additionalSetup() {
        self.backgroundColor = Colors.darkBlue
    }
}



