//
//  Date+String.swift
//  Mov
//
//  Created by Allan on 10/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation

extension Date{
    
    var year: String?{
        guard let year = Calendar.current.dateComponents([.year], from: self).year else { return nil}
        return "\(year)"
    }
    
    var toString: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: self)
    }
    
    init?(with dateText: String, andFormat format: String){
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        guard let dateFormat = formatter.date(from: dateText) else{
            return nil
        }
        self.init(timeInterval: 0, since: dateFormat)
    }
}
