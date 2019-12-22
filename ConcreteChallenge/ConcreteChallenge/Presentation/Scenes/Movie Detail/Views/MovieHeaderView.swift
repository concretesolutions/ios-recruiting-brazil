//
//  MovieHeaderView.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MovieHeaderView: UIView, ViewCodable {
    var viewAtributtes: (title: String?, subTitle: String?) {
        set {
            titleLabel.text = newValue.title
            subTitleLabel.text = newValue.subTitle
        } get {
            return (titleLabel.text, subTitleLabel.text)
        }
    }

    var favoriteButtonTapCompletion: (() -> Void)? {
        didSet {
            faveImageView.favoriteButtonTapCompletion = self.favoriteButtonTapCompletion
        }
    }
    
    private let titleLabel = UILabel().build {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.text = "title"
        $0.textColor = .white
    }
    private let subTitleLabel = UILabel().build {
        $0.text = "subtible"
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
    }
    private lazy var faveImageView = FavoriteImageView(imagesForState: [
        .faved: UIImage(named: "cleanFaved")!,
        .unfaved: UIImage(named: "cleanUnfaved")!]).build {
        $0.favoriteButtonTapCompletion = self.favoriteButtonTapCompletion
    }
    
    private let marginsLayoutGuide = UILayoutGuide()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteState(isFaved: Bool) {
        self.faveImageView.isFaved = isFaved
    }
    
    func buildHierarchy() {
        addSubViews(titleLabel, subTitleLabel, faveImageView)
        addLayoutGuide(marginsLayoutGuide)
    }
    
    func addConstraints() {
        marginsLayoutGuide.layout.fill(view: self, margin: 10)
        titleLabel.layout.group.left.top.right.fill(to: marginsLayoutGuide)
        subTitleLabel.layout.build {
            $0.group.left.bottom.right.fill(to: marginsLayoutGuide)
            $0.top.equal(to: titleLabel.layout.bottom, offsetBy: 20)
            $0.height.equal(to: 20)
        }
        faveImageView.layout.build {
            $0.group.right.bottom.fill(to: marginsLayoutGuide)
            $0.width.equal(to: 30)
            $0.height.equal(to: $0.width)
        }
    }
    
    func applyAditionalChanges() {
        backgroundColor = .appRed
        layer.build {
            $0.cornerRadius = 10
            $0.shadowOpacity = 0.5
            $0.shadowOffset = .zero
        }
    }
}
