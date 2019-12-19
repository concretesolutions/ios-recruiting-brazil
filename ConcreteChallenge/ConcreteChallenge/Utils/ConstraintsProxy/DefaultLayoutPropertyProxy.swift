//
//  DefaultLayoutPropertyProxy.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A type to make possible have references to a LayoutPropertyProxy.
struct DefaultLayoutPropertyProxy<AnchorType: AnyObject>: LayoutPropertyProxy {
    var anchor: NSLayoutAnchor<AnchorType>
}
