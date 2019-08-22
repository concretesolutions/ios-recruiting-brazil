//
//  MovsSingleton.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

class MovsSingleton {
  
  static let shared = MovsSingleton()
  
  var globalSettings: Settings?
  var genres: [Genres] = []
  var allMovies: [Movies] = []
  
  var avaliableDates: [String] {
    return self.generateDates()
  }
  
  private init() {}
  
  fileprivate func generateDates() -> [String] {
    var dates = [String]()
    let calendar = Calendar.current

    let actualYear = calendar.component(.year, from: Date())
    
    for year in 1900...actualYear {
      dates.append("\(year)")
    }
    
    return dates.reversed()
  }
  
}
