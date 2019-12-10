//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import SnapKit

class MoviesCollectionViewCell: UICollectionViewCell {

    var viewModel: MovieViewModel!

    let verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        return stackView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "marvel")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()

    let horizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        return stackView
    }()

    let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Vingadores Ultimato"
        label.textColor = .black
        return label
    }()

    let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.imageView?.image = UIImage(named: "heart_normal")
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = UIColor(named: "cellBackground")
        self.layer.cornerRadius = 8.0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withViewModel viewModel: MovieViewModel) {
        self.movieTitle.text = viewModel.title
    }

}

extension MoviesCollectionViewCell: ViewCode {

    func buildViewHierarchy() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(movieTitle)
    }

    func setupContraints() {
        verticalStackView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        horizontalStackView.snp.makeConstraints { (make) in
            make.height.equalTo(48.0)
        }
    }

    func setupAdditionalConfiguration() {}

}
