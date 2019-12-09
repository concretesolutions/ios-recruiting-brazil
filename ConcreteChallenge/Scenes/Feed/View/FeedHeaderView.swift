//
//  FeedHeaderView.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

class FeedHeaderView: UIView {
    
    // MARK: - Properties -
    // MARK: View
    internal var headlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        if #available(iOS 13.0, *) {
            label.font = UIFont.roundedBold(17)
        } else {
            // Fallback on earlier versions
            label.font = UIFont.bold(17)
        }
        return label
    }()

    internal var callToActionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        if #available(iOS 13.0, *) {
            label.font = UIFont.roundedBold(27)
        } else {
            // Fallback on earlier versions
            label.font = UIFont.bold(27)
        }
        return label
    }()
    
    // MARK: - Init -
    override init(frame: CGRect) {

        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -
    /// Setup the view's UI
    func setupUI() {
        self.addSubview(headlineLabel)
        self.addSubview(callToActionLabel)
    }

    /// Setup the view's Constraints
    func setupConstraints() {
        setNeedsDisplay()

        headlineLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalTo(self.snp.trailing).offset(-20.0)
            make.bottom.equalTo(callToActionLabel.snp.top)
        }

        callToActionLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(headlineLabel)
        }
    }
}
