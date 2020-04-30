//
//  UIColor+AssetColor.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(asset: Colors) {
        switch asset {
        case .brand:
            self.init(named: "Brand")!
        case .darkBrand:
            self.init(cgColor: UIColor(asset: .brand).darker(by: 30)!.cgColor)
        case .darkerBrand:
            self.init(cgColor: UIColor(asset: .brand).darker(by: 50)!.cgColor)
        case .darkestBrand:
            self.init(cgColor: UIColor(asset: .brand).darker(by: 80)!.cgColor)
        }
    }
}
