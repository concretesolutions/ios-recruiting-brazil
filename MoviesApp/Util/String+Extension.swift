//
//  String+Extension.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 18/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

extension String{
    
    func getYear() -> Int?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: self){
            let calendar = NSCalendar.current
            let year = calendar.component(.year, from: date)
            return year
        }else{
            return nil
        }
    }
    
}
