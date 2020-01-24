//
//  String.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var base64ToImage: UIImage? {
        guard let dataDecoded = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: dataDecoded)
    }
}


