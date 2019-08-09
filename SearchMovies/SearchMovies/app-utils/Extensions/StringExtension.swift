//
//  StringExtension.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: .init(rawValue: 0)) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data.base64EncodedString(options: .init(rawValue: 0))
    }
    
    func toDate(format:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
}
