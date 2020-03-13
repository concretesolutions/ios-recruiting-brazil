//
//  Data+PrettyPrint.swift
//  CommonsModule
//
//  Created by Marcos Felipe Souza on 13/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//
import Foundation

public extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
