//
//  DateFilterCell.swift
//  Movs
//
//  Created by Dielson Sales on 08/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class DateFilterCell: UITableViewCell {

    var year: Int?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
