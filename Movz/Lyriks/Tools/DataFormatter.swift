//
//  DataFormatter.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import Foundation

extension DateFormatter {
    func years<R: RandomAccessCollection>(_ range: R) -> [String] where R.Iterator.Element == Int {
        setLocalizedDateFormatFromTemplate("yyyy")
        let res = range.compactMap { DateComponents(calendar: calendar, year: $0).date }.flatMap { string(from: $0) }
        var result:[String] = [""]
        var index = 0
        for i in 0...(res.count - 1){
            result[index].append(res[i])
            if result[index].count%4==0{
                index += 1
                result.append("")
            }
        }
        result.removeLast()
        return result.reversed()
    }
}
