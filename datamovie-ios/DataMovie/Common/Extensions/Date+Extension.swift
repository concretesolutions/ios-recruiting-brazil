//
//  Date+Extension.swift
//  DataMovie
//
//  Created by Andre on 26/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

extension Date {
    
    init?(dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
            return nil
        }
        self = date
    }
    
    func stringFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long //"MMMM dd, yyyy" - us
        return dateFormatter.string(from: self)
    }
}
