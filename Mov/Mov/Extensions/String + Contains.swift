//
//  String + Contains.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

extension String {
    func contains(_ string: String) -> Bool {
        if let _ = self.lowercased().range(of: string.lowercased()) {
            return true
        } else { return false }
    }
}
