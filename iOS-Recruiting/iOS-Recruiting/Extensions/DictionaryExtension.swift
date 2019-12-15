//
//  DictionaryExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation


protocol StringType {}

extension String : StringType {}

extension Dictionary where Key: StringType {
    
    
    internal func toJSONString() -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "")
        } catch {
            Log.shared.show(error: error.localizedDescription)
        }
        return nil
    }

}
