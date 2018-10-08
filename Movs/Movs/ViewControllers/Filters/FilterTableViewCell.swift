//
//  FilterTableViewCell.swift
//  Movs
//
//  Created by Dielson Sales on 07/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
