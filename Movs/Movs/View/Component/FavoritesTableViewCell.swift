//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Lucca Ferreira on 03/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor(named: "cellBackground")
        return view
    }()

    let contentContainerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private let posterImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "marvel")
        return imageView
    }()

    private let textContainerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 0
        label.text = "Uma descrição qualquer de um texto bem legal de um projeto do qual eu não sei nada sabe"
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "2018"
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.text = "Vingadores Ultimato"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesTableViewCell: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(containerView)
        self.containerView.addSubview(posterImage)
        self.containerView.addSubview(textContainerView)
        self.textContainerView.addSubview(titleLabel)
        self.textContainerView.addSubview(yearLabel)
        self.textContainerView.addSubview(overviewLabel)
    }

    func setupContraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().inset(16.0)
        }
        self.posterImage.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(self.posterImage.snp.height).multipliedBy(0.8)
        }
        self.textContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
            make.left.equalTo(self.posterImage.snp.right).offset(16.0)
            make.right.equalToSuperview().inset(16.0)
        }
        self.yearLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
//            make.right.greaterThanOrEqualTo(self.yearLabel.snp.left)
        }
        self.overviewLabel.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(2.0)
        }
    }

    func setupAdditionalConfiguration() {
        
    }

}
