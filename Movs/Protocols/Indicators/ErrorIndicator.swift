//
//  ErrorIndicator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 17/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

@objc protocol ErrorIndicator {
    @objc optional func showSearchError()
    @objc optional func showNetworkError()
    @objc optional func retryConnection(_ sender: UIButton)
}
