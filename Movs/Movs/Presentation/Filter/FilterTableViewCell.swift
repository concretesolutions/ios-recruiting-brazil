//
//  FilterTableViewCell.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

class FilterTableViewCell: UITableViewCell, Reusable {

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy var parameterLabel: UILabel = {
        let parameterLabel = UILabel(frame: .zero)
        parameterLabel.translatesAutoresizingMaskIntoConstraints = false
        return parameterLabel
    }()

    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView(frame: .zero)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        return arrowImageView
    }()

    func setupOption(with text: String, parameter: String) {
        self.titleLabel.text = text
        self.parameterLabel.text = parameter
        self.parameterLabel.isHidden = false
        arrowImageView.image = UIImage(named: "arrowIcon")
        setupView()
    }

    func setupParameter(with text: String, isSelecetd: Bool) {
        self.titleLabel.text = text
        self.parameterLabel.isHidden = true
        arrowImageView.image = UIImage(named: "check_icon")
        DispatchQueue.main.async {
            self.arrowImageView.isHidden = !isSelecetd
        }
        setupView()
    }

}

extension FilterTableViewCell: CodeView {

    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(parameterLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        }

        parameterLabel.snp.makeConstraints { make in
            make.trailing.equalTo(arrowImageView.snp.leading)
            make.centerY.equalToSuperview()
        }

    }

    func setupAdditionalConfiguration() {
        self.titleLabel.textColor = .black
        self.titleLabel.numberOfLines = 1
        arrowImageView.contentMode = .scaleAspectFit
        self.parameterLabel.numberOfLines = 1
        self.parameterLabel.textColor = Design.Colors.darkYellow
        self.parameterLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        self.selectionStyle = .none
    }
}
