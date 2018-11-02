//
//  Date+Extension.swift
//  AppMovie
//
//  Created by Renan Alves on 02/11/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import Foundation

extension Date {
    static func convertDateFormatter(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: stringDate)
        
        return newDate
    }
    
    static func getComponent(from component: Calendar.Component,at date: Date) -> Int{
        let calendar = Calendar.current
        let componentSelected = calendar.component(.year, from: date)
        
        return componentSelected
    }
}
