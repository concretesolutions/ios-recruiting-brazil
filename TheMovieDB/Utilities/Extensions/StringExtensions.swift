//
//  StringExtensions.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 25/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
