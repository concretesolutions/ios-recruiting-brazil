//
//  Help.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 13/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import Foundation

class Help {
    
    static let shared = Help()
    
    func formatYear(date: String) -> String {
        if (date != "") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-mm-dd"
            let dateComplete = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "YYYY"
            let dateYear = dateFormatter.string(from: dateComplete!)
            return String(dateYear)
        } else {
            return String("-")
        }        
    }
    
    func formatGenre(generos: [String]) -> String {
        var genreFormat = ""
        //print(generos.count)
        for i in 0 ..< generos.count {
            if (generos[i] != "") {
                genreFormat = "\(generos[i])"
            }
        }
        return genreFormat
    }
    
    func runThisAfterDelay(seconds: Double, after: @escaping () -> Void) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }
    
    func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}
