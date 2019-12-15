//
//  ItemCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import SnapKit

final class ItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties -
    /// Height / Width
    static let imageAspect: CGFloat = (1080/1920)
    
    // MARK: View
    let filmImageView: GradientImageView = {
        let view = GradientImageView(frame: .zero)
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteEmpty"), for: .normal)
        return button
    }()
    
    /// Changes the display image for the favorite button depending on the state
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(UIImage(named: isFavorite ? "favoriteFull" : "favoriteEmpty"), for: .normal)
        }
    }
    
    // MARK: - Methods -
    override func setupUI() {
        
        // Make the button able to be pressed
        filmImageView.isUserInteractionEnabled = true
        
        contentView.addSubview(filmImageView)
        filmImageView.addSubview(titleLabel)
        filmImageView.addSubview(favoriteButton)
    }
    
    override func setupConstraints() {
        
        filmImageView.snp.makeConstraints { (make) in
            let imageWidth = UIScreen.main.bounds.width - 40
            make.center.equalToSuperview()
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth * ItemCollectionViewCell.imageAspect)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(favoriteButton.snp.leading)
        }
    }
}
