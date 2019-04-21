//
//  FilterTableViewCell.swift
//  movs
//
//  Created by Lorien Moisyn on 21/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    var checkedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkedImageView = UIImageView(image: UIImage(named: "check_icon") ?? UIImage())
        self.addSubview(checkedImageView)
        checkedImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        checkedImageView.isHidden = true
    }

}
