//
//  String+DateFormater.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 15/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

extension String {
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy"
        return dateFormatter2.string(from: date ?? Date())
        
    }
}
