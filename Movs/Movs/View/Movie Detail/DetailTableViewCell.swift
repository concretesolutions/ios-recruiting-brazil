//
//  DetailTableViewCell.swift
//  Movs
//
//  Created by Erick Lozano Borges on 19/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Reusable

protocol FavouriteCellButtonDelegate {
    func didPressButton(withFavouriteStatus shouldFavourite:Bool)
}

class DetailTableViewCell: UITableViewCell, Reusable {

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
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        if isFavourite {
            button.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        } else {
            button.setImage(UIImage(named: "favorite_empty_icon")!, for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var separator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Design.colors.dark
        return view
    }()
    
    //MARK: - Properties
    fileprivate var hasButton: Bool = false
    fileprivate var isFavourite = false
    fileprivate var hasSeparator: Bool = false
    fileprivate var delegate: FavouriteCellButtonDelegate?
    
    //MARK: - Setup
    func setup(withText text: String) {
        label.text = text
        setupView()
    }
    
    func setup(withText text: String,
               withButton: Bool = false,
               withSeparator: Bool = false,
               delegate: FavouriteCellButtonDelegate? = nil,
               isFavourite: Bool = false) {
        self.hasButton = withButton
        self.hasSeparator = withSeparator
        self.isFavourite = isFavourite
        self.delegate = delegate
        self.setup(withText: text)
    }

    //MARK: - Actions
    @objc
    func handleTap() {
        if isFavourite == false {
            favouriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "favorite_empty_icon")!, for: .normal)
        }
        isFavourite = !isFavourite
        delegate?.didPressButton(withFavouriteStatus: isFavourite)
    }
}

extension DetailTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(label)
        if hasButton {
            contentView.addSubview(favouriteButton)
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
            favouriteButton.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(label.snp.right).offset(5)
                make.right.equalToSuperview().inset(20)
                make.height.equalTo(favouriteButton.snp.width)
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
