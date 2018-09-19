//
//  String+Util.swift
//  Pedida de hoje
//
//  Created by Jonathan Martins on 01/06/18.
//  Copyright © 2016 Jussi. All rights reserved.
//

import Foundation
import UIKit

extension Optional where Wrapped == String {

    /// Converts a string date to a given format
    func formatDate(fromPattern:String, toPattern: String)->String?{
        guard let date = self else{
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromPattern
        dateFormatter.locale     = Locale(identifier: "en")
        
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = toPattern
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
