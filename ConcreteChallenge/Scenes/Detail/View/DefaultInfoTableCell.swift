//
//  DefaultInfoTableCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

final class DefaultInfoTableCell: BaseTableViewCell {
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        let fontSize: CGFloat = 15
        if #available(iOS 13.0, *) {
            textLabel?.font = UIFont.rounded(fontSize)
        } else {
            textLabel?.font = UIFont.regular(fontSize)
        }
        textLabel?.textColor = Colors.almostBlack
        textLabel?.numberOfLines = 0
    }
}
