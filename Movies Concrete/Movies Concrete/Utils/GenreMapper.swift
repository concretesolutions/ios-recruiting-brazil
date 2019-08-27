//
//  GenreMapper.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 26/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation

struct GenreMapper {
  
  static func getGenreData(genresId: [Int]) -> [String] {
    var genderList: [String] = []
    for id in genresId {
      
      if id == 28 {
        genderList.append("Action")
      }
      
      if id == 12 {
        genderList.append("Adventure")
      }
      
      if id == 16 {
        genderList.append("Animation")
      }
      
      if id == 35 {
        genderList.append("Comedy")
      }
      
      if id == 80 {
        genderList.append("Crime")
      }
      
      if id == 99 {
        genderList.append("Documentary")
      }
      
      if id == 18 {
        genderList.append("Drama")
      }
      
      if id == 10751 {
        genderList.append("Family")
      }
      
      if id == 14 {
        genderList.append("Fantasy")
      }
      
      if id == 14 {
        genderList.append("Fantasy")
      }
      
      if id == 36 {
        genderList.append("History")
      }
      
      if id == 27 {
        genderList.append("Horror")
      }
      
      if id == 10402 {
        genderList.append("Music")
      }
      
      if id == 9648 {
        genderList.append("Mystery")
      }
      
      if id == 10749 {
        genderList.append("Romance")
      }
      
      if id == 878 {
        genderList.append("Science Fiction")
      }
      
      if id == 10770 {
        genderList.append("TV Movie")
      }
      
      if id == 53 {
        genderList.append("Thriller")
      }
      
      if id == 10752 {
        genderList.append("War")
      }
      
      if id == 37 {
        genderList.append("Western")
      }
      
    }
    
    return genderList
  }
  
}

