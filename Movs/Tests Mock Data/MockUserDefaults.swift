//
//  MockUserDefaults.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 23/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Foundation

class MockUserDefaults: UserDefaults {

    // MARK: - Initializers

    convenience init() {
        self.init(suiteName: "Mock")!
    }

    // MARK: - Clear

    func clear() {
        self.removePersistentDomain(forName: "Mock")
    }
}
