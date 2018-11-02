//
//  DetailsTitleTableViewCell.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class DetailsTitleTableViewCell: UITableViewCell {
    
    var toggleFavoriteAction: (() -> Void)?
    
    lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = UIFont(name: Fonts.helveticaNeueBold, size: CGFloat(20).proportionalToWidth)
        title.textAlignment = .left
        title.numberOfLines = 2
        
        return title
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: MovieDetailsViewModel) {
        self.titleLabel.text = viewModel.title
        self.favoriteButton.setImage(viewModel.isFavoriteIcon, for: .normal)
    }
    
    func setTextLabel(settings: @escaping (UILabel) -> Void) {
        guard let textLabel = self.textLabel else { return }
        settings(textLabel)
    }
    
    @objc func toggleFavorite() {
        guard let action = self.toggleFavoriteAction else { return }
        action()
    }
    
}

extension DetailsTitleTableViewCell: ViewCode {
    func addView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.favoriteButton)
    }
    
    func addConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(CGFloat(15).proportionalToWidth)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        self.favoriteButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
            make.centerY.equalToSuperview()
        }
    }
    
    
}
