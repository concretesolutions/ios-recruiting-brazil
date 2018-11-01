//
//  DetailsTitleTableViewCell.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class DetailsTitleTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = UIFont(name: Fonts.helveticaNeue, size: CGFloat(20).proportionalToWidth)
        title.textAlignment = .left
        
        return title
    }()
    
    lazy var isFavoriteIcon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.contentMode = .scaleAspectFit
        
        return icon
    }()
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String, isFavorite: Bool) {
//        self.textLabel.text = title
        self.isFavoriteIcon.image = isFavorite ? Images.isFavoriteIconFull : Images.isFavoriteIconGray
    }
    
    func setTextLabel(settings: @escaping (UILabel) -> Void) {
        guard let textLabel = self.textLabel else { return }
        settings(textLabel)
    }
    
}

extension DetailsTitleTableViewCell: ViewCode {
    func addView() {
//        self.addSubview(self.titleLabel)
        self.addSubview(self.isFavoriteIcon)
    }
    
    func addConstraints() {
//        self.titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.left.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(0.5)
//        }
        
        self.isFavoriteIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    
}
