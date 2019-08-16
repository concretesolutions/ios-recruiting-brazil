//
//  FilterViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

//MARK: - The head of the class
class FilterViewModel{
    var filters = ["Date","Genre"]
    var results = ["Nenhum","Nenhum"]
    
    weak var delegate: ReturnFilter?
    var years = [String]()
    var genres = [String]()
    
    init() {
        let df = DateFormatter()
        years.append("Nenhum")
        years.append(contentsOf: df.years(1980...2019).reversed())
        
        genres.append("Nenhum")
        for genre in APIController.allGenres{
            genres.append(genre.name)
        }
    }
}



// Function to get a list of all the years utilizing the DateFormatter
extension DateFormatter {
    func years<R: RandomAccessCollection>(_ range: R) -> [String] where R.Iterator.Element == Int {
        setLocalizedDateFormatFromTemplate("yyyy")
        let res = range.compactMap { DateComponents(calendar: calendar, year: $0).date }.compactMap { string(from: $0)}
        
        return res
    }
}
