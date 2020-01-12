//
//  Identifiable.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

protocol Identifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Identifiable {}
extension UICollectionViewCell: Identifiable {}
