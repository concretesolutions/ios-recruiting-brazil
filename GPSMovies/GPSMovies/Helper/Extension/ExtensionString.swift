//
//  ExtensionString.swift
//  GPSMovies
//
//  Created by Gilson Santos on 09/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation

extension String {
    
    func getStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateService = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt-BR")
        return dateFormatter.string(from: dateService)
    }
    
}
