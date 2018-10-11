//
//  Double+Extension.swift
//  DataMovie
//
//  Created by Andre on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

extension Double {
    
    func decimalFormat() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = ""
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 2
//        currencyFormatter.locale = Locale(identifier: "pt_BR")
        if let doubleFormatted = currencyFormatter.string(from: self as NSNumber) {
            return doubleFormatted
        }
        return "0,00"
    }
    
}
