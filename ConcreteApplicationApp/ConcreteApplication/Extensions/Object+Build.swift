//
//  Object+Build.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 22/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import RealmSwift

extension Object {
    static func build<T: Object>(_ builder: (T) -> Void ) -> T {
        let rlm = T()
        builder(rlm)
        return rlm
    }
}
