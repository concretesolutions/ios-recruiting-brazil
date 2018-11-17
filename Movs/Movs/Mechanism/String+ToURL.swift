//
//  String+ToURL.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
