//
//  HTTPResponse.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
