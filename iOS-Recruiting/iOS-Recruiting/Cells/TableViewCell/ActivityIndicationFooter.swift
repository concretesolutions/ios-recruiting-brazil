//
//  ActivityIndicationFooter.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class ActivityIndicationFooter: UICollectionReusableView {

   @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
}


extension ActivityIndicationFooter: ReusableView, NibLoadableView {}
