//
//  FilterCategoryTableViewCell.swift
//  movies
//
//  Created by Jacqueline Alves on 18/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

final class FilterCategoryTableViewCell: UITableViewCell {
    private var viewModel: FilterCategoryCellViewModel! {
        didSet {
            self.nameLabel.text = self.viewModel.name
            self.bindOptions()
        }
    }
    
    lazy var nameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        
        return view
    }()
    
    lazy var optionsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .systemOrange
        view.textAlignment = .right
        view.numberOfLines = 1
        
        return view
    }()
    
    // Cancellables
    private var optionsSubscriber: AnyCancellable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setViewModel(_ viewModel: FilterCategoryCellViewModel) {
        self.viewModel = viewModel
    }
    
    private func bindOptions() {
        optionsSubscriber?.cancel()
        optionsSubscriber = self.viewModel.$options
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] options in
                self?.optionsLabel.text = options
            })
    }
}

extension FilterCategoryTableViewCell: CodeView {
    
    func buildViewHierarchy() {
        addSubview(nameLabel)
        addSubview(optionsLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        optionsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.left.equalTo(nameLabel.snp.right)
            make.right.equalToSuperview().inset(40)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
    }
}
