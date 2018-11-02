//
//  DetailsLabelTableViewCell.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class DetailsDefaultLabelTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: Fonts.helveticaNeue, size: CGFloat(18).proportionalToWidth)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        
        self.setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension DetailsDefaultLabelTableViewCell: ViewCode {
    func addView() {
        self.addSubview(self.label)
    }
    
    func addConstraints() {
        self.label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(CGFloat(15).proportionalToWidth)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    
}
