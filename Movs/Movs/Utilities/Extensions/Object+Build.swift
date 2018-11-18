//
//  Object+Build.swift
//  Movs
//
//  Created by Erick Lozano Borges on 11/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

extension Object {
    static func build<T: Object>(_ builder: (T) -> Void ) -> T {
        let rlm = T()
        builder(rlm)
        return rlm
    }
}
