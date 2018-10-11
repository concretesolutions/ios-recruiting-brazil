//
//  DMShared.swift
//  DataMovie
//
//  Created by Andre Souza on 10/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class DMShared {
    
    static let shared = DMShared()
    var needUpdateCollection: Bool = false
    
    private init() { }
    
}
