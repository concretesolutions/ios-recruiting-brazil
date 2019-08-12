//
//  LoadingCell.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 12/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.startAnimating()
        }
    }
}
