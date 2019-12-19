//
//  LayoutPropertyProxy.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A proxy to a layout property. This protocol make possible refers to a especific anchor from a view.
/// It also makes possible adding new methods for handling constraints
protocol LayoutPropertyProxy {
    associatedtype AnchorType: AnyObject
    
    var anchor: NSLayoutAnchor<AnchorType> { get set }
    init(anchor: NSLayoutAnchor<AnchorType>)
}
