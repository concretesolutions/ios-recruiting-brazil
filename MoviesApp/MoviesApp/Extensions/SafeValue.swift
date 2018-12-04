//
//  SafeValue.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

extension Int {
    init(safeValue: Any?) {
        self = safeValue as? Int ?? 0
    }
}

extension String {
    init(safeValue: Any?) {
        self = safeValue as? String ?? ""
    }
}
