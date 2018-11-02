//
//  PopularMovie.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 01/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

struct Page: Codable {
  let page: Int
  let total_results: Int
  let total_pages: Int
  let results: [PopularMovie]
  
}

struct PopularMovie: Codable {
  let vote_count: Int
  let id: Int
  let title: String
  let poster_path: String
  let overview: String
  let release_date: String
  
}
