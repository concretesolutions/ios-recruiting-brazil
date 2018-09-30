//
//  Object.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import RealmSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> Void ) -> O {
        let object = O()
        builder(object)
        return object
    }
}
