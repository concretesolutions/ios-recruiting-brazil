//
//  DetailTableViewCell.swift
//  Movs
//
//  Created by Erick Lozano Borges on 19/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Reusable

class DetailTableViewCell: UITableViewCell, Reusable {
    
    //MARK: - Properties
    fileprivate var hasButton: Bool = false
    fileprivate var isFavorite = false
    fileprivate var hasSeparator: Bool = false
    fileprivate weak var delegate: FavoriteCellButtonDelegate?

    //MAR: - Interface
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = Design.colors.dark
        label.backgroundColor = Design.colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        if isFavorite {
            button.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        } else {
            button.setImage(UIImage(named: "favorite_gray_icon")!, for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var separator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Design.colors.dark.withAlphaComponent(0.5)
        return view
    }()
    
    //MARK: - Setup
    func setup(withText text: String) {
        label.text = text
        setupView()
    }
    
    func setup(withText text: String,
               withButton: Bool = false,
               withSeparator: Bool = false,
               delegate: FavoriteCellButtonDelegate? = nil,
               isFavorite: Bool = false) {
        self.hasButton = withButton
        self.hasSeparator = withSeparator
        self.isFavorite = isFavorite
        self.delegate = delegate
        self.setup(withText: text)
    }

    //MARK: - Actions
    @objc
    func handleTap() {
        if isFavorite == false {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon")!, for: .normal)
        }
        isFavorite = !isFavorite
        delegate?.didPressButton(withFavoriteStatus: isFavorite)
    }
}

//MARK: - CodeView
extension DetailTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(label)
        if hasButton {
            contentView.addSubview(favoriteButton)
        }
        if hasSeparator {
            contentView.addSubview(separator)
        }
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            if hasButton {
                make.width.equalToSuperview().inset(40)
            } else {
                make.right.equalToSuperview().inset(20)
            }
        }
        
        if hasButton {
            favoriteButton.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(label.snp.right).offset(5)
                make.right.equalToSuperview().inset(20)
                make.height.equalTo(favoriteButton.snp.width)
            }
        }
        
        if hasSeparator {
            separator.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(0.5)
            }
        }
        
    }
}
