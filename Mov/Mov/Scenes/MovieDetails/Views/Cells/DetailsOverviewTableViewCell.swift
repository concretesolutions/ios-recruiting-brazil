//
//  DetailsOverviewTableViewCell.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class DetailsOverviewTableViewCell: UITableViewCell {

    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: Fonts.helveticaNeue, size: CGFloat(14).proportionalToWidth)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.baselineAdjustment = UIBaselineAdjustment.alignBaselines
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.setup()
        
    }
    
    func set(text: String) {
        self.label.text = text
        self.label.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension DetailsOverviewTableViewCell: ViewCode {
    func addView() {
        self.addSubview(self.label)
    }
    
    func addConstraints() {
        self.label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat(15).proportionalToWidth)
            make.left.equalToSuperview().inset(CGFloat(15).proportionalToWidth)
            make.right.equalToSuperview().inset(CGFloat(15).proportionalToWidth)
        }
    }
}
