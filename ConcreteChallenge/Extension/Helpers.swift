//
//  Helpers.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

struct Helpers {
    static func loadXib<T>(named xibName: String, owner: Any) -> T? {
        return  Bundle.main.loadNibNamed(xibName, owner: owner, options: nil)?.first as? T
    }
}
