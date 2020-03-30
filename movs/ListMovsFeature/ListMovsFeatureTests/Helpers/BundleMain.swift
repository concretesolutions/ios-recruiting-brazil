//
//  BundleMain.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

class BundleMain {
    
    private lazy var bundle: Bundle = Bundle(for: type(of: self))
    
    func file(with name: String) -> Data? {
        guard let path = self.bundle.path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return nil
        }
        
        return data
    }
}
