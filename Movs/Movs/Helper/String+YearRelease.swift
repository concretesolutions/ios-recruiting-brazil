//
//  String+YearRelease.swift
//  Movs
//
//  Created by Maisa on 28/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

extension String {
    
    static func getYearRelease (fullDate: String?) -> String {
        if let date = fullDate {
            let data = date.split(separator: "-")
            return data.count > 0 ? String(data.first!) : ""
        }
        return ""
    }
}
