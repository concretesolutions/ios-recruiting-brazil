//
//  MainTableViewCell.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class MainTableViewCell:UITableViewCell{
    static let cellHeigth:CGFloat = 80
    static let identifier = "main_cell"
    
    let title:UILabel = {
        let view = UILabel()
        return view
    }()
    let rate:UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViewCoding()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
        Set dat on UI.
    */
    func setUp(model:TableCellViewModel){
        self.rate.attributedText = model.vote
        self.title.attributedText = model.title
        self.contentView.backgroundColor = model.colors["background"]
       

    }
    
}

extension MainTableViewCell:ViewCoding{
    func buildViewHierarchy() {
        self.addSubview(self.title)
        self.addSubview(self.rate)
    }
    
    func setUpConstraints() {
        self.title.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: self.contentView.bottomAnchor, trailing: self.rate.leadingAnchor)
        self.rate.anchor(top: self.contentView.topAnchor, leading: nil, bottom: self.contentView.bottomAnchor, trailing: self.contentView.trailingAnchor)
        self.rate.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    func additionalConfigs() {
    }
    
    
}
