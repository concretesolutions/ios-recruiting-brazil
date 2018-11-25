//
//  FilterTableViewCell.swift
//  Movs
//
//  Created by Erick Lozano Borges on 21/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Reusable

enum FilterTableViewCellStyle {
    case push
    case parameter
}

class FilterTableViewCell: UITableViewCell, Reusable {
    
    //MARK: - Properties
    // Configuration
    var style: FilterTableViewCellStyle = .push
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = Design.colors.dark
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectedOptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = Design.colors.mainYellow
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        switch style {
        case .push:
            imageView.image = UIImage(named: "disclosure_Indicator")
        case .parameter:
            imageView.image = UIImage(named: "check_icon")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setup(description:String) {
        style = .parameter
        selectionStyle = .none
        descriptionLabel.text = description
        hideDetail()
        setupView()
    }
    
    func setup(description:String, selectedOption:String?) {
        style = .push
        selectionStyle = .none
        descriptionLabel.text = description
        selectedOptionLabel.text = selectedOption
        setupView()
    }
    
    func hideDetail() {
        self.detailImageView.isHidden = true
    }
    
    func showDetail() {
        self.detailImageView.isHidden = false
    }
    
}

extension FilterTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(selectedOptionLabel)
        contentView.addSubview(detailImageView)
    }
    
    func setupConstraints() {
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().offset(20)
        }

        selectedOptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel.snp.right).offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        detailImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(selectedOptionLabel.snp.right).offset(10).priority(.high)
            make.left.equalTo(descriptionLabel.snp.right).offset(10).priority(.low)
            make.right.equalToSuperview().inset(20)
            switch style {
            case .push:
                make.width.equalTo(8)
                make.height.equalTo(13)
            case .parameter:
                make.width.equalTo(18)
                make.height.equalTo(14)
            }
        }
    }
}

