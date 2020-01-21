//
//  String+Extension.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 21/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation


extension String {
    func dateToYear() -> String? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let newDate = dateFormatter.date(from: self) else { return nil }
        let components = Calendar.current.dateComponents([.year], from: newDate)
        guard let year = components.year else { return nil }
        return "\(year)"
    }
}
