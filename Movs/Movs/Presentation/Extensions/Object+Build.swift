//
//  Object+Build.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import RealmSwift

extension Object {

    static func build<T: Object>(_ builder: (T) -> Void ) -> T {
        let rlm = T()
        builder(rlm)
        return rlm
    }
}
